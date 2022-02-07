//
//  LocationManager.swift
//  Climately
//
//  Created by Mohammad Yasir on 07/02/22.
//

import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate  {
    @Published public var authorizationStatus: CLAuthorizationStatus
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        requestPermission()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    public func getCoordinate(
        addressString : String,
        completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void
    ) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            guard error != nil else {
                completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
                return
            }
            
            if let placemark = placemarks?[0] {
                let location = placemark.location!
                
                completionHandler(location.coordinate, nil)
                return
            }
        }
    }
    
    public func getAddress(
        coordinates: CLLocationCoordinate2D,
        completionHandler: @escaping(CLPlacemark?, NSError?) -> Void
    ) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(.init(latitude: coordinates.latitude, longitude: coordinates.longitude)) { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                completionHandler(firstLocation, nil)
            }
            
            completionHandler(nil, error as NSError?)
            
        }
    }
}
