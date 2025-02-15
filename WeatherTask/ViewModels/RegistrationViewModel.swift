//
//  RegistrationViewModel.swift
//  WeatherTask
//
//  Created by Michael Winkler on 15.02.25.
//


import SwiftUI

class RegistrationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var isConfirmPasswordVisible: Bool = false
    @Published var errorMessage: String?
    @Published var isRegistered: Bool = false

    var isRegisterButtonEnabled: Bool {
        !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty
    }

    func register() {
        guard isRegisterButtonEnabled else {
            errorMessage = "Bitte fülle alle Felder aus."
            return
        }

        guard isValidEmail(email) else {
            errorMessage = "Bitte gib eine gültige E-Mail-Adresse ein."
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Passwörter stimmen nicht überein."
            return
        }

        // TODO: Registrierung implementieren (z. B. API-Call)
        print("User registriert: \(email)")
        isRegistered = true
        errorMessage = nil
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
