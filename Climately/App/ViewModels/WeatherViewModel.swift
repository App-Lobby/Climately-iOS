//
//  WeatherViewModel.swift
//  Climately
//
//  Created by Mohammad Yasir on 05/02/22.
//

import SwiftUI
import CoreLocation

class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var weather: APIResponse = .init()
    @Published var searched: String = "Bengaluru" {
        didSet {
            makeAPICall()
        }
    }
    
    @Published var searchedCoordinates: CLLocationCoordinate2D = .init()
    
    @Published var authorizationStatus: CLAuthorizationStatus
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        requestPermission()
        makeAPICall()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    public func makeAPICall() -> Void {
        getCoordinate(addressString: searched) { coordinates, error in
            self.searchedCoordinates = coordinates
            ServiceManager.getCurrentWeatherData(
                key: "da6abe8ec13dffbea262e927ed379fb7",
                lat: coordinates.latitude,
                lon: coordinates.longitude
            ) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.weather = data
                    }
                case .failure(let error):
                    print("HERE IS THE ISSUEE", error.localizedDescription)
                }
            }
        }
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
}

extension WeatherViewModel {
    func getCoordinate(
        addressString : String,
        completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
            
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(addressString) { (placemarks, error) in
                if error == nil {
                    if let placemark = placemarks?[0] {
                        let location = placemark.location!
                        
                        completionHandler(location.coordinate, nil)
                        return
                    }
                }
                
                completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
            }
        }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

