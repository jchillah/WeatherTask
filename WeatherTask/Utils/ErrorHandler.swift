//
//  ErrorHandler.swift
//  WeatherTask
//
//  Created by Michael Winkler on 14.02.25.
//

import Foundation

@MainActor
class ErrorHandler: ObservableObject {
    @Published var errorMessage: String?

    func handle(error: Error) {
        if let authError = error as? AuthError {
            errorMessage = authError.errorDescription
        } else if let localizedError = error as? LocalizedError, let description = localizedError.errorDescription {
            errorMessage = description
        } else {
            errorMessage = "Ein unbekannter Fehler ist aufgetreten."
        }
    }

    func clearError() {
        errorMessage = nil
    }
}

enum AuthError: Error, LocalizedError {
    case invalidEmail
    case incorrectCredentials
    case weakPassword
    case emailAlreadyInUse
    case networkError
    case unknownError

    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Bitte geben Sie eine gültige E-Mail-Adresse ein."
        case .incorrectCredentials:
            return "Login fehlgeschlagen. Überprüfen Sie Ihre E-Mail und Ihr Passwort."
        case .weakPassword:
            return "Das Passwort ist zu schwach. Bitte verwenden Sie ein stärkeres Passwort."
        case .emailAlreadyInUse:
            return "Diese E-Mail-Adresse wird bereits verwendet."
        case .networkError:
            return "Netzwerkfehler. Bitte überprüfen Sie Ihre Internetverbindung."
        case .unknownError:
            return "Ein unbekannter Fehler ist aufgetreten."
        }
    }
}
