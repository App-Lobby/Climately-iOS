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
    
    @Published var queryLocationInfo: QueryLocationInfo = .init()
    
//    @Published var searchedCoordinates: CLLocationCoordinate2D = .init(latitude: 12.9716, longitude: 77.5946)
//    @Published var queryCity: String = "Bengaluru"
    
    @Published var popUp: PopUp = .init()
    
    init() {
        setUpWeather()
    }
    
    public func setUpWeather() -> Void {
        locationObj.getCoordinate(addressString: queryLocationInfo.queryCity) { coordinates, error in
            guard error == nil else {
                self.queryLocationInfo.queryCoordinates = .init()
                self.weather = .init()
                self.popUp.popUpType = .wentWrong
                self.popUp.showPopUp = true
                return
            }
            
            guard let coordinates = coordinates else { return }

            self.queryLocationInfo.queryCoordinates = coordinates
            
            ServiceManager.getCurrentWeatherData(
                key: "da6abe8ec13dffbea262e927ed379fb7",
                lat: self.queryLocationInfo.queryCoordinates.latitude,
                lon: self.queryLocationInfo.queryCoordinates.longitude
            ) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.weather = data
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self.popUp.popUpType = .wentWrong
                        self.popUp.showPopUp = true
                    }
                }
            }
        }
    }
}
