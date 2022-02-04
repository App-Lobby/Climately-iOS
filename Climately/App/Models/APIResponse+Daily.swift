//
//  APIResponse+Daily.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

extension APIResponse {
    public struct Daily: Decodable {
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
            
        public struct Temp: Decodable {
            public var day: Double
            
            init(day: Double) {
                self.day = day
            }
        }
        
        public struct Weather: Decodable {
            public var id: Int
            
            init(id: Int) {
                self.id = id
            }
        }
    }
}
