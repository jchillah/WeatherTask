//
//  WeatherViewModel.swift
//  WeatherTask
//
//  Created by Michael Winkler on 17.02.25.
//

import Foundation
import CoreLocation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var temperature: String = "--°C"
    
    private let weatherService = WeatherService()

    func fetchWeather() async {
            if let weather = try? await weatherService.getWeather() {
                self.temperature = "\(Int(weather.temperature))°C"
            
        }
    }
}
