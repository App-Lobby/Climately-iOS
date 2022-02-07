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
    
    private var searchWorkItem: DispatchWorkItem? = nil
    private let citySearchQueue = DispatchQueue(label: "city", qos: .userInitiated)
    
    @Published var searchedCoordinates: CLLocationCoordinate2D = .init(latitude: 12.9716, longitude: 77.5946)
//    @Published var searchedAddress: String = "Bengaluru"
    @Published var queryCity: String = "Bengaluru" {
        didSet {
            searchWorkItem?.cancel()
            searchWorkItem = DispatchWorkItem { [weak self] in
                self?.prepareForCall()
                self?.makeAPICall()
            }
            
            guard let searchWorkItem = searchWorkItem else {
                assertionFailure()
                return
            }
            
            citySearchQueue.asyncAfter(deadline: .now() + 2, execute: searchWorkItem)
        }
    }
    
    init() {
        prepareForCall()
        makeAPICall()
    }
    
    private func prepareForCall() -> Void {
        locationObj.getCoordinate(addressString: queryCity) { coordinates, error in
            if let coordinates = coordinates {
                print("LONG",coordinates.longitude)
                print("LANT",coordinates.latitude)
                self.searchedCoordinates = coordinates
            }
        }
        
//        locationObj.getAddress(coordinates: searchedCoordinates) { address, error in
//            if let address = address {
//                print("ADDRESS", address)
//                self.searchedAddress = address
//            }
//        }
    }
    
    private func makeAPICall() -> Void {
        ServiceManager.getCurrentWeatherData(
            key: "da6abe8ec13dffbea262e927ed379fb7",
            lat: searchedCoordinates.latitude,
            lon: searchedCoordinates.longitude
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
