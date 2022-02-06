//
//  Extension+DateFormatter.swift
//  Climately
//
//  Created by Mohammad Yasir on 05/02/22.
//

import SwiftUI

extension DateFormatter {
    static var hourMin: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }
    
    static var todayTommorowDate: DateFormatter {
        let formtter = DateFormatter()
        formtter.timeStyle = .none
        formtter.dateStyle = .medium
        formtter.locale = Locale(identifier: "en_GB")
        formtter.doesRelativeDateFormatting = true
        return formtter
    }
    
    static var dateMonth: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter
    }
}
