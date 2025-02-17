//
//  WeatherService.swift
//  WeatherTask
//
//  Created by Michael Winkler on 17.02.25.
//

import Foundation

struct Weather: Decodable {
    let temperature: Double
}

class WeatherService {
    func getWeather() async throws -> Weather {
        // Hier kannst du die API-Anfrage implementieren
        return Weather(temperature: 22.5) // Platzhalterwert
    }
}
