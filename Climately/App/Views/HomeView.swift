//
//  HomeView.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var weatherViewModel: WeatherViewModel = .init()
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
                            NavigationLink(destination: HourlyForcastView(weatherViewModel: weatherViewModel)) {
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
        ForEach(weatherViewModel.weather.current.getCurrentWeatherData(), id: \.id) { data in
            HStack {
                Text("\(data.title)")
                Spacer()
                Text("\(data.data)")
                if data.haveAsset { Image(systemName: weatherViewModel.weather.current.getSfName) }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
