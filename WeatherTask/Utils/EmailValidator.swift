//
//  EmailValidator.swift
//  WeatherTask
//
//  Created by Michael Winkler on 15.02.25.
//

import Foundation

@MainActor
struct EmailValidator {
    static func isValid(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
