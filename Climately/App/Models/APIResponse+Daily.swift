//
//  APIResponse+Daily.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

extension APIResponse {
    public struct Daily: Decodable {
        public var id: UUID = .init()
        public var dt: Date?
        public var temp: Temp
        public var weather: [Weather]
        
        enum CodingKeys: CodingKey {
            case dt, temp, weather
        }
        
        init(
            id: UUID,
            dt: Date? = nil,
            temp: Temp = .init(),
            weather: [Weather] = []
        ) {
            self.id = id
            self.dt = dt
            self.temp = temp
            self.weather = weather
        }
            
        public struct Temp: Decodable {
            public var day: Double?
            
            enum CodingKeys: CodingKey {
                case day
            }
            
            init(day: Double? = nil) {
                self.day = day
            }
        }
        
        public struct Weather: Decodable {
            public var id: Int?
            
            enum CodingKeys: CodingKey {
                case id
            }
            
            public var weatherSFName: String {
                guard let id = id else { return "" }
                
                switch id {
                case 200...232:
                    return "cloud.bolt.rain"
                case 300...301:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.sun"
                default:
                    return "cloud.sun"
                }
            }
            
            init(id: Int? = nil) {
                self.id = id
            }
        }
        
        public var getDate: String {
            guard let safeDate = dt else { return "Loading" }
            return DateFormatter.dateMonth.string(from: safeDate)
        }
        
        public var getTime: String {
            guard let safeTime = dt else { return "Loading" }
            return DateFormatter.hourMin.string(from: safeTime)
        }
        
        public var getTemp: String {
            guard let safeTemp = temp.day else { return "Loading" }
            return String(safeTemp)
        }
        
        public var getSfName: String {
            guard !weather.isEmpty else { return "exclamationmark.triangle" }
            return weather[0].weatherSFName
        }
    }
}
