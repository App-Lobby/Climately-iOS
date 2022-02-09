//
//  PopUpEnums.swift
//  Climately
//
//  Created by Mohammad Yasir on 09/02/22.
//

import SwiftUI

public enum PopUpType {
    case nothing
    case wentWrong
    
    public var title: String {
        switch self {
        case .nothing:
            return ""
        case .wentWrong:
            return "City Not Found"
        }
    }
    
    public var message: String {
        switch self {
        case .nothing:
            return ""
        case .wentWrong:
            return "Either weak internate or wrong city name. Please try again"
        }
    }
}
