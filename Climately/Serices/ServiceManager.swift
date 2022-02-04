//
//  ServiceManager.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

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
