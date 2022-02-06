//
//  HomeView.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var weatherViewModel: WeatherViewModel = .init()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Sections.allCases, id: \.self) { section in
                    Section(header: Text(section.header)) {
                        switch section {
                        case .CITY:
                            HStack {
                                Text(weatherViewModel.searched)
                                Spacer()
                                Text("\(weatherViewModel.searchedCoordinates.latitude), \(weatherViewModel.searchedCoordinates.longitude)")
                            }
                        case .CURRENTWEATHER:
                            currentWeatherInfoView()
                        case .WEATHERFORCAST:
                            NavigationLink(destination: HourlyForcastView(weatherViewModel: weatherViewModel)) {
                                Text("Get Hourly Forcast")
                            }
                            
                            NavigationLink(destination: DailyForcastView(weatherViewModel: weatherViewModel)) {
                                Text("Get Daily Forcast")
                            }
                        }
                    }
                }
            }
            .searchable(text: $weatherViewModel.searched)
            .navigationTitle("Climately")
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

