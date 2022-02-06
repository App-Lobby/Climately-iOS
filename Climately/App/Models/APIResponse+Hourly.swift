//
//  APIResponse+Hourly.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

extension APIResponse {
    public struct Hourly: Decodable {
        public var id: UUID = .init()
        public var dt: Date?
        public var temp: Double?
        public var weather: [Weather]
        
        enum CodingKeys: String, CodingKey {
            case dt, temp, weather
        }
        
        internal init(
            id: UUID,
            dt: Date?,
            temp: Double?,
            weather: [Weather] = []
        ) {
            self.id = id
            self.dt = dt
            self.temp = temp
            self.weather = weather
        }
        
        public struct Weather: Decodable {
            public var id: Int?
            
            enum CodingKeys: String, CodingKey {
                case id
            }
            
            internal init(id: Int? = nil) {
                self.id = id
            }
            
            public var weatherSFName: String {
                guard let id = id else { return "" }
                
                switch id {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...621:
                    return "cloud.snow"
                default:
                    return "cloud"
                }
            }
        }

        public var getTime: String {
            guard let safeDate = dt else { return "" }
            return DateFormatter.hourMin.string(from: safeDate)
        }
        
        public var getDate: String {
            guard let safeDate = dt else { return "" }
            return DateFormatter.dateMonth.string(from: safeDate)
        }
        
        public var getTemp: String {
            guard let temp = temp else { return "" }
            return String(temp)
        }
        
        public var getSfName: String {
            guard !weather.isEmpty else { return "exclamationmark.triangle" }
            return weather[0].weatherSFName
        }

    }
}
