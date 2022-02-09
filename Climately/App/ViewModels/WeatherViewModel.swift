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
    
    @Published var showPopUp: Bool = false
    @Published var popUpType: PopUpType = .nothing
    
    init() {
        setUpWeather()
    }
    
    public func setUpWeather() -> Void {
        locationObj.getCoordinate(addressString: queryCity) { coordinates, error in
            guard error == nil else {
                self.searchedCoordinates = .init()
                self.weather = .init()
                self.popUpType = .wentWrong
                self.showPopUp = true
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
                case .failure(_):
                    DispatchQueue.main.async {
                        self.popUpType = .wentWrong
                        self.showPopUp = true
                    }
                }
            }
        }
    }
}

