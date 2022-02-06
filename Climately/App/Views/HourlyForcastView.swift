//
//  HourlyForcastView.swift
//  Climately
//
//  Created by Mohammad Yasir on 05/02/22.
//

import SwiftUI

struct HourlyForcastView: View {
    @ObservedObject var weatherViewModel: WeatherViewModel 

    var body: some View {
        List {
            ForEach(weatherViewModel.weather.hourly, id: \.id) { hourly in
                HStack {
                    Text(hourly.getDate)
                    Spacer()
                    Text(hourly.getTime)
                    Spacer()
                    Text(hourly.getTemp)
                    Spacer()
                    Image(systemName: hourly.getSfName)
                }
            }
        }
        .navigationBarTitle("Hourly")
        .listStyle(GroupedListStyle())
    }
}

struct DailyForcastView: View {
    @ObservedObject var weatherViewModel: WeatherViewModel

    var body: some View {
        List {
            ForEach(weatherViewModel.weather.daily, id: \.id) { daily in
                HStack {
                    Text(daily.getDate)
                    Spacer()
                    Text(daily.getTime)
                    Spacer()
                    Text(daily.getTemp)
                    Spacer()
                    Image(systemName: daily.getSfName)
                }
            }
        }
        .navigationBarTitle("Hourly")
        .listStyle(GroupedListStyle())
    }
}
