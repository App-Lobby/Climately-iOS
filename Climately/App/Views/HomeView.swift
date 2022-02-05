//
//  HomeView.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: WeatherViewModel = .init()
    @State var search: String = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Sections.allCases, id: \.self) { section in
                    Section(header: Text(section.header)) {
                        switch section {
                        case .CITY:
                            HStack {
                                Text("Bengaluru")
                                Spacer()
                                Text("44.91, -10.33")
                            }
                        case .CURRENTWEATHER:
                            currentWeatherInfoView()
                        case .WEATHERFORCAST:
                            NavigationLink(destination: Text("welcome to hourly")) {
                                Text("Get Hourly Forcast")
                            }
                            
                            NavigationLink(destination: Text("welcome to daily")) {
                                Text("Get Daily Forcast")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Climately")
            .searchable(text: $search)
            .listStyle(GroupedListStyle())
        }
    }
    
    private func currentWeatherInfoView() -> some View {
        ForEach(viewModel.weather.current.getCurrentWeatherData(), id: \.id) { data in
            HStack {
                Text("\(data.title)")
                Spacer()
                Text("\(data.data as! String)")
            }
        }
//        Text("\(viewModel.weather.current.tempAsString())")
//        ForEach(Array(viewModel.currentWeatherData.children), id: \.label) { child in
//            HStack {
//                Text("\(child.label!)")
//                Spacer()
//                Text("\(String(describing: child.value))")
//            }
//        }
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
