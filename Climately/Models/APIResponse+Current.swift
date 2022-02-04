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
        
        public struct Weather: Decodable {
            public var id: Int
            
            init(id: Int) {
                self.id = id
            }
        }
    }
}
