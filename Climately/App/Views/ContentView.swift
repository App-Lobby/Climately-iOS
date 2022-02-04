//
//  ContentView.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                ServiceManager.getCurrentWeatherData(key: "6fcda4db7aabf9cf2c61c59f04882b22", lat: 33.44, lon: -94.04) { result in
                    switch result {
                    case .success(let data):
                        print(data)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



