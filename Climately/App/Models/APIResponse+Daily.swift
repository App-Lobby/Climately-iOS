//
//  APIResponse+Daily.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

extension APIResponse {
    public struct Daily: Decodable {
        public var dt: Date?
        public var temp: Temp?
        public var weather: [Weather]?
        
        internal init(
            dt: Date? = nil,
            temp: Temp? = nil,
            weather: [Weather]? = []
        ) {
            self.dt = dt
            self.temp = temp
            self.weather = weather
        }
            
        public struct Temp: Decodable {
            public var day: Double?
            
            internal init(day: Double? = nil) {
                self.day = day
            }
        }
        
        public struct Weather: Decodable {
            public var id: Int?
            
            internal init(id: Int? = nil) {
                self.id = id
            }
        }
    }
}
