//
//  LocationManager.swift
//  Climately
//
//  Created by Mohammad Yasir on 07/02/22.
//

import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate  {
    @Published private var authorizationStatus: CLAuthorizationStatus
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        requestPermission()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}

extension LocationManager {
    public func getCoordinate(
        addressString : String,
        completionHandler: @escaping(CLLocationCoordinate2D?, NSError?) -> Void
    ) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            guard error == nil else {
                completionHandler(nil, error as NSError?)
                return
            }
            
            if let safeLocation = placemarks?[0].location!.coordinate {
                completionHandler(safeLocation, nil)
                return
            }
        }
    }
}

extension LocationManager {
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
}
