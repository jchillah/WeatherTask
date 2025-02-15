//
//  RegistrationViewModel.swift
//  WeatherTask
//
//  Created by Michael Winkler on 15.02.25.
//


import SwiftUI

@MainActor
class RegistrationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var isConfirmPasswordVisible: Bool = false
    @Published var errorMessage: String?
    @Published var isRegistered: Bool = false

    private let errorHandler = ErrorHandler()

    var isRegisterButtonEnabled: Bool {
        !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty
    }

    func register() {
        guard isRegisterButtonEnabled else {
            errorMessage = "Bitte fülle alle Felder aus."
            return
        }

        guard isValidEmail(email) else {
            errorHandler.handle(error: AuthError.invalidEmail)
            errorMessage = errorHandler.errorMessage
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Passwörter stimmen nicht überein."
            return
        }

        Task {
            do {
                try await AuthManager.shared.signUp(email: email, password: password)
                isRegistered = true
                errorMessage = nil
            } catch {
                errorHandler.handle(error: error)
                errorMessage = errorHandler.errorMessage
            }
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
