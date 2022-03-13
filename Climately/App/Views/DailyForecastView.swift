//
//  DailyForecastView.swift
//  Climately
//
//  Created by Mohammad Yasir on 13/03/22.
//

import SwiftUI

struct DailyForecastView: View {
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
