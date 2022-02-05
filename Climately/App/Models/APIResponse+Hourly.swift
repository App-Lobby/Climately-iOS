//
//  APIResponse+Hourly.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

extension APIResponse {
    public struct Hourly: Decodable {
        public var dt: Date?
        public var temp: Double?
        public var weather: [Weather]
        
        internal init(
            dt: Date?,
            temp: Double?,
            weather: [Weather] = []
        ) {
            self.dt = dt
            self.temp = temp
            self.weather = weather
        }
        
        public struct Weather: Decodable {
            public var id: Int?
            
            internal init(id: Int? = nil) {
                self.id = id
            }
        }
    }
}
