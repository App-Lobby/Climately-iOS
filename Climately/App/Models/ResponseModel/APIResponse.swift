//
//  APIResponse.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

public struct APIResponse: Decodable {
    public var current: Current
    public var hourly: [Hourly]
    public var daily: [Daily]
    
    enum CodingKeys: String, CodingKey {
        case current, hourly, daily
    }
    
    init(
        current: Current = .init(),
        hourly: [Hourly] = [],
        daily: [Daily] = []
    ) {
        self.current = current
        self.hourly = hourly
        self.daily = daily
    }
    
}
