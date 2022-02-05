//
//  ViewEnums.swift
//  Climately
//
//  Created by Mohammad Yasir on 05/02/22.
//

import SwiftUI

enum Sections: CaseIterable {
    
    case CITY
    case CURRENTWEATHER
    case WEATHERFORCAST
    
    public var header: String {
        switch self {
        case .CITY:
            return "CITY"
        case .CURRENTWEATHER:
            return "CURRENT WEATHER"
        case .WEATHERFORCAST:
            return "WEATHER FORCAST"
        }
    }
    
}
