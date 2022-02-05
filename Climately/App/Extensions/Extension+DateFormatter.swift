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
}
