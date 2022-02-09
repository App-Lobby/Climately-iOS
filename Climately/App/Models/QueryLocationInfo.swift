//
//  QueryLocationInfo.swift
//  Climately
//
//  Created by Mohammad Yasir on 09/02/22.
//

import SwiftUI
import CoreLocation

public struct QueryLocationInfo {
    public var queryCity: String
    public var queryCoordinates: CLLocationCoordinate2D
    
    init(
        queryCity: String = "Bengaluru",
        queryCoordinates: CLLocationCoordinate2D = .init(latitude: 12.9716, longitude: 77.5946)
    ) {
        self.queryCity = queryCity
        self.queryCoordinates = queryCoordinates
    }
}
