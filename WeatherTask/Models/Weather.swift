//
//  Weather.swift
//  WeatherTask
//
//  Created by Michael Winkler on 19.02.25.
//

import Foundation

@MainActor
struct Weather: Decodable {
    let temperature: Double
}
