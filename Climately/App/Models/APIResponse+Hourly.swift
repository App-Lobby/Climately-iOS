//
//  APIResponse+Hourly.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

extension APIResponse {
    public struct Hourly: Identifiable, Decodable {
        public var id: UUID?
        public var dt: Date?
        public var temp: Double?
        public var weather: [Weather]
        
        internal init(
            id: UUID? = .init(),
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
        
        public struct HourlyDataType: Identifiable {
            public var id: UUID = .init()
            public var time: String
            public var date: String
            public var temp: String
        }
        
        public var getTime: String {
            guard let getDate = dt else { return "" }
            return DateFormatter.hourMin.string(from: getDate)
        }
        
        public var getDate: String {
            guard let getDate = dt else { return "" }
            return DateFormatter.todayTommorowDate.string(from: getDate)
        }
        
        public var getTemp: String {
            guard let temp = temp else { return "" }
            return String(temp)
        }
        
        public var getSfName: String {
            guard !weather.isEmpty else { return "exclamationmark.triangle" }
            return weather[0].weatherSFName
        }
        
        public func getHourlyWeatherData() -> [HourlyDataType] {
            var data: [HourlyDataType] = []
            data.append(.init(time: getTime, date: getDate, temp: getTemp))
            return data
        }
    }
}
