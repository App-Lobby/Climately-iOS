//
//  APIResponse+Current.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

extension APIResponse {
    public struct Current: Decodable {
        public var temp: Double
        public var pressure: Int
        public var humidity: Int
        public var wind_speed: Double
        public var sunrise: Date
        public var sunset: Date
        public var weather: [Weather]
        
        init(
            temp: Double = 0,
            pressure: Int = 0,
            humidity: Int = 0,
            wind_speed: Double = 0,
            sunrise: Date = Date(),
            sunset: Date = Date(),
            weather: [APIResponse.Current.Weather] = []
        ) {
            self.temp = temp
            self.pressure = pressure
            self.humidity = humidity
            self.wind_speed = wind_speed
            self.sunrise = sunrise
            self.sunset = sunset
            self.weather = weather
        }
        
        public struct Weather: Decodable {
            public var id: Int
            
            init(id: Int) {
                self.id = id
            }
            
            public var weatherSFName: String {
                switch id {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                default:
                    return "cloud"
                }
            }
        }
        
        public struct CurrentDataType: Identifiable {
            public var id: UUID = .init()
            public var title: String
            public var data: Any
        }
        
        public var tempAsString: String {
            return String(temp)
        }
        
        public var humidityAsString: String {
            return String(humidity)
        }
        
        public func weatherAssetId() -> Int {
            return weather[0].id
        }
        
        public func getCurrentWeatherData() -> [CurrentDataType] {
            var data: [CurrentDataType] = []
            data.append(.init(title: "Temperature", data: tempAsString))
            data.append(.init(title: "Humidity", data: humidityAsString))
            return data
        }
    }
}
