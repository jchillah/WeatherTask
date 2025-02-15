//
//  ErrorHandler.swift
//  WeatherTask
//
//  Created by Michael Winkler on 14.02.25.
//

import Foundation

class ErrorHandler: ObservableObject {
    @Published var errorMessage: String?

    func handle(error: Error) {
        if let localizedError = error as? LocalizedError, let description = localizedError.errorDescription {
            errorMessage = description
        } else {
            errorMessage = "Ein unbekannter Fehler ist aufgetreten."
        }
    }

    func clearError() {
        errorMessage = nil
    }
}


enum LoginError: Error, LocalizedError {
    case invalidEmail
    case incorrectCredentials

    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Bitte tragen Sie eine gültige E-Mail ein."
        case .incorrectCredentials:
            return "Login fehlgeschlagen. Bitte überprüfen Sie die E-Mail oder das Passwort."
        }
    }
}
