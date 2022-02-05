//
//  APIResponse.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

public struct APIResponse: Identifiable, Decodable {
    public var id: UUID?
    public var current: Current
    public var hourly: [Hourly]
    public var daily: [Daily]
    
    internal init(
        id: UUID? = .init(),
        current: Current = .init(),
        hourly: [Hourly] = [],
        daily: [Daily] = []
    ) {
        self.id = id
        self.current = current
        self.hourly = hourly
        self.daily = daily
    }
}
