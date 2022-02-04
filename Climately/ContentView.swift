//
//  ContentView.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                ServiceManager.getCurrentWeatherData(key: "6fcda4db7aabf9cf2c61c59f04882b22", lat: 33.44, lon: -94.04) { result in
                    switch result {
                    case .success(let data):
                        print(data)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct CurrentAPIResponse: Decodable {
    var current: Current
    
    init(current: Current) {
        self.current = current
    }
    
    struct Current: Decodable {
        var temp: Double
        var pressure: Int
        var humidity: Int
        var wind_speed: Double
        var sunrise: Date
        var sunset: Date
        var weather: [Weather]
        
        init(
            temp: Double,
            pressure: Int,
            humidity: Int,
            wind_speed: Double,
            sunrise: Date,
            sunset: Date,
            weather: [CurrentAPIResponse.Current.Weather]
        ) {
            self.temp = temp
            self.pressure = pressure
            self.humidity = humidity
            self.wind_speed = wind_speed
            self.sunrise = sunrise
            self.sunset = sunset
            self.weather = weather
        }
        
        struct Weather: Decodable {
            var id: Int
            
            init(id: Int) {
                self.id = id
            }
        }
    }
}

enum NetworkError: Error {
    case wrongURL, timeOut, dataNotFound
}

enum NetworkMethods: String {
    case GET = "GET"
    case POST = "POST"
}

struct ServiceManager {
    static func getCurrentWeatherData (
        key: String,
        lat: Double,
        lon: Double,
        completionHandler: @escaping (Result<CurrentAPIResponse, NetworkError>) -> ()
    ) {
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&appid=\(key)")
        
        guard let safeURL = url else {
            completionHandler(.failure(NetworkError.wrongURL))
            return
        }
        
        var request = URLRequest(url: safeURL)
        request.httpMethod = NetworkMethods.GET.rawValue
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completionHandler(.failure(NetworkError.timeOut))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(CurrentAPIResponse.self, from: data)
                completionHandler(.success(decodedData))
            } catch {
                completionHandler(.failure(NetworkError.dataNotFound))
            }
            
        }.resume()
    }
}
