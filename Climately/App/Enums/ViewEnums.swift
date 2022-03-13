//
//  ViewEnums.swift
//  Climately
//
//  Created by Mohammad Yasir on 05/02/22.
//

import SwiftUI

public enum Sections: CaseIterable {
    
    case CITY
    case CURRENTWEATHER
    case WEATHERFORECAST
    
    public var header: String {
        switch self {
        case .CITY:
            return "CITY"
        case .CURRENTWEATHER:
            return "CURRENT WEATHER"
        case .WEATHERFORECAST:
            return "WEATHER FORECAST"
        }
    }
    
}
