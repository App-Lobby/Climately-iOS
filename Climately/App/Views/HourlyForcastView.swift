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
                DayInfoView(hourly: hourly)
            }
        }
    }
}

struct DayInfoView: View {
    public var hourly: APIResponse.Hourly

    var body: some View {
        ForEach(hourly.getHourlyWeatherData(), id: \.id) { data in
            HStack {
                Text(data.date)
                Spacer()
                Text(data.time)
                Spacer()
                Text(data.temp)
                Spacer()
                Text("Image")
            }
        }
    }
}
