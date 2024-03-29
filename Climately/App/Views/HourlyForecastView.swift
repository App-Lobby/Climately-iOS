//
//  HourlyForcastView.swift
//  Climately
//
//  Created by Mohammad Yasir on 05/02/22.
//

import SwiftUI

struct HourlyForecastView: View {
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

