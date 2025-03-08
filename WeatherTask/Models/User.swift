//
//  User.swift
//  WeatherTask
//
//  Created by Michael Winkler on 17.02.25.
//


import Foundation

class User: Codable, Identifiable {
    let id: String
    let email: String
    let signedUpOn: Date
    
  init (id: String, email: String, signedUpOn: Date) {
        self.id = id
        self.email = email
        self.signedUpOn = signedUpOn
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case signedUpOn = "signed_up_on"
    }
}

