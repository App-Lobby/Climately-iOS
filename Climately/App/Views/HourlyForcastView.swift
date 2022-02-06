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
                }
            }
        }
        .navigationBarTitle("Hourly")
        .listStyle(GroupedListStyle())
    }
}
