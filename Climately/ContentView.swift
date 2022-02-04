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

struct APIResponse: Decodable {
    public var current: Current
    public var hourly: [Hourly]
    public var daily: [Daily]
    
    init(
        current: Current,
        hourly: [Hourly],
        daily: [Daily]
    ) {
        self.current = current
        self.hourly = hourly
        self.daily = daily
    }
}

extension APIResponse {
    struct Current: Decodable {
        public var temp: Double
        public var pressure: Int
        public var humidity: Int
        public var wind_speed: Double
        public var sunrise: Date
        public var sunset: Date
        public var weather: [Weather]
        
        init(
            temp: Double,
            pressure: Int,
            humidity: Int,
            wind_speed: Double,
            sunrise: Date,
            sunset: Date,
            weather: [APIResponse.Current.Weather]
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
            public var id: Int
            
            init(id: Int) {
                self.id = id
            }
        }
    }
}

extension APIResponse {
    struct Hourly: Decodable {
        public var dt: Date
        public var temp: Double
        public var weather: [Weather]
        
        init(
            dt: Date,
            temp: Double,
            weather: [Weather]
        ) {
            self.dt = dt
            self.temp = temp
            self.weather = weather
        }
        
        struct Weather: Decodable {
            public var id: Int
            
            init(id: Int) {
                self.id = id
            }
        }
    }
}

extension APIResponse {
    struct Daily: Decodable {
        public var dt: Date
        public var temp: Temp
        public var weather: [Weather]
        
        init(
            dt: Date,
            temp: Temp,
            weather: [Weather]
        ) {
            self.dt = dt
            self.temp = temp
            self.weather = weather
        }
            
        struct Temp: Decodable {
            public var day: Double
            
            init(day: Double) {
                self.day = day
            }
        }
        
        struct Weather: Decodable {
            public var id: Int
            
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
        completionHandler: @escaping (Result<APIResponse, NetworkError>) -> ()
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
                let decodedData = try decoder.decode(APIResponse.self, from: data)
                completionHandler(.success(decodedData))
            } catch {
                completionHandler(.failure(NetworkError.dataNotFound))
            }
            
        }.resume()
    }
}
