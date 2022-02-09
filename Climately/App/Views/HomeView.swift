//
//  HomeView.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var weatherViewModel: WeatherViewModel = .init()
    @State var text = ""
    var body: some View {
        NavigationView {
            List {
                ForEach(Sections.allCases, id: \.self) { section in
                    Section(header: Text(section.header)) {
                        switch section {
                        case .CITY:
                                HStack {
                                    TextField("Enter City Name", text: $weatherViewModel.queryLocationInfo.queryCity) {
                                        weatherViewModel.setUpWeather()
                                    }
                                    Spacer()
                                    Text("\(weatherViewModel.queryLocationInfo.queryCoordinates.latitude), \(weatherViewModel.queryLocationInfo.queryCoordinates.longitude)")
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
            .navigationTitle("Climately")
            .listStyle(GroupedListStyle())
            .navigationBarItems(trailing: Button(action: {
                weatherViewModel.setUpWeather()
            }, label: {
                Text("Reload")
            }))
            .alert(isPresented: $weatherViewModel.popUp.showPopUp) {
                Alert(
                    title: Text(weatherViewModel.popUp.popUpType.title),
                    message: Text(weatherViewModel.popUp.popUpType.message),
                    dismissButton: .cancel()
                )
            }
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

