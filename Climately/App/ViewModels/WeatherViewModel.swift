//
//  WeatherViewModel.swift
//  Climately
//
//  Created by Mohammad Yasir on 05/02/22.
//

import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var weather: APIResponse = .init()
    
    init() {
        makeAPICall()
    }
    
    public func makeAPICall() -> Void {
        ServiceManager.getCurrentWeatherData(key: "da6abe8ec13dffbea262e927ed379fb7", lat: 26.8467, lon: 80.9462) { result in
            switch result {
            case .success(let data):
                print(data.hourly)
//                DispatchQueue.main.async {
//                    self.weather = data
//                }
            case .failure(let error):
                print("HERE IS THE ISSUEE", error.localizedDescription)
            }
        }
    }
}
