//
//  WeatherViewModel.swift
//  Climately
//
//  Created by Mohammad Yasir on 05/02/22.
//

import SwiftUI
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var weather: APIResponse = .init()
    @Published var locationObj: LocationManager = .init()
    
    @Published var searchedCoordinates: CLLocationCoordinate2D = .init(latitude: 12.9716, longitude: 77.5946)
    @Published var queryCity: String = "Bengaluru"
    
    init() {
        setUpWeather()
    }
    
    public func setUpWeather() -> Void {
        locationObj.getCoordinate(addressString: queryCity) { coordinates, error in
            if let error = error {
                print("Error while getting coordinate", error.localizedDescription)
                // Mark:- Pop-up with no city found
                
                // Mark:- Making nil the fields
                self.searchedCoordinates = .init()
                self.weather = .init()
                return
            }
            
            guard let coordinates = coordinates else { return }

            self.searchedCoordinates = coordinates
            
            ServiceManager.getCurrentWeatherData(
                key: "da6abe8ec13dffbea262e927ed379fb7",
                lat: self.searchedCoordinates.latitude,
                lon: self.searchedCoordinates.longitude
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
}
