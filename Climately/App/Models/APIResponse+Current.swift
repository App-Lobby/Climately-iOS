//
//  APIResponse+Current.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

extension APIResponse {
    public struct Current: Decodable {
        public var temp: Double?
        public var pressure: Int?
        public var humidity: Int?
        public var wind_speed: Double?
        public var sunrise: Date?
        public var sunset: Date?
        public var weather: [Weather]
        
        private enum CodingKeys: String, CodingKey {
            case temp, pressure, humidity, wind_speed, sunrise, sunset, weather
        }
        
        internal init(
            temp: Double? = nil,
            pressure: Int? = nil,
            humidity: Int? = nil,
            wind_speed: Double? = nil,
            sunrise: Date? = nil,
            sunset: Date? = nil,
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
            public var id: Int?
            
            private enum CodingKeys: String, CodingKey {
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
        
        public struct CurrentDataType: Identifiable {
            public var id: UUID
            public var title: String
            public var data: String
            public var haveAsset: Bool
            
            internal init(
                id: UUID = .init(),
                title: String,
                data: String,
                haveAsset: Bool = false
            ) {
                self.id = id
                self.title = title
                self.data = data
                self.haveAsset = haveAsset
            }
        }
        
        public var getTemp: String {
            guard let temp = temp else { return "" }
            return String(temp)
        }
        
        public var getPressure: String {
            guard let pressure = pressure else { return "" }
            return String(pressure)
        }
        
        public var getHumidity: String {
            guard let humidity = humidity else { return "" }
            return String(humidity)
        }
        
        public var getWindSpeed: String {
            guard let wind_speed = wind_speed else { return "" }
            return String(wind_speed)
        }
        
        public var getSunRise: String {
            guard let sunrise = sunrise else { return "" }
            return DateFormatter.hourMin.string(from: sunrise)
        }
        
        public var getSunSet: String {
            guard let sunset = sunset else { return "" }
            return DateFormatter.hourMin.string(from: sunset)
        }
        
        public var getSfName: String {
            guard !weather.isEmpty else { return "exclamationmark.triangle" }
            return weather[0].weatherSFName
        }
        
        public func getCurrentWeatherData() -> [CurrentDataType] {
            var data: [CurrentDataType] = []
            data.append(.init(title: "Temperature", data: getTemp, haveAsset: true))
            data.append(.init(title: "Pressure", data: getPressure))
            data.append(.init(title: "Humidity", data: getHumidity))
            data.append(.init(title: "Wind Speed", data: getWindSpeed))
            data.append(.init(title: "Sun Rise", data: getSunRise))
            data.append(.init(title: "Sun Set", data: getSunSet))
            return data
        }
    }
}



