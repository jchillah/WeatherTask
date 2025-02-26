//
//  User.swift
//  WeatherTask
//
//  Created by Michael Winkler on 17.02.25.
//


import Foundation

struct User: Codable, Identifiable {
    let id: String
    let email: String
    let signedUpOn: Date
}