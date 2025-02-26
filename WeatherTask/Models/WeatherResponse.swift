//
//  WeatherResponse.swift
//  WeatherTask
//
//  Created by Michael Winkler on 17.02.25.
//

import Foundation

@MainActor 
struct WeatherResponse: Codable {
    struct Main: Codable {
        var temp: Double
    }
    var main: Main
}
