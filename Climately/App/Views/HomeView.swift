//
//  HomeView.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

struct HomeView: View {
//    @ObservedObject var viewModel: WeatherViewModel = .init()
    @State var search: String = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Sections.allCases, id: \.self) { section in
                    Section(header: Text(section.header)) {
                        switch section {
                        case .CITY:
                            Text("A loop with city info")
                        case .CURRENTWEATHER:
                            Text("A loop with current weather info")
                        case .WEATHERFORCAST:
                            Text("A loop with two forcast navigationlink")
                        }
                    }
                }
            }
            .navigationTitle("Climately")
            .searchable(text: $search)
            .listStyle(GroupedListStyle())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

class WeatherViewModel: ObservableObject {
    @Published var weather: APIResponse = .init()
    
    init() {
        makeAPICall()
    }
    
    public func makeAPICall() -> Void {
        ServiceManager.getCurrentWeatherData(key: "6fcda4db7aabf9cf2c61c59f04882b22", lat: 26.8467, lon: 80.9462) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.weather = data
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

enum Sections: CaseIterable {
    
    case CITY
    case CURRENTWEATHER
    case WEATHERFORCAST
    
    public var header: String {
        switch self {
        case .CITY:
            return "CITY"
        case .CURRENTWEATHER:
            return "CURRENT WEATHER"
        case .WEATHERFORCAST:
            return "WEATHER FORCAST"
        }
    }
    
}
