//
//  RegistrationViewModel.swift
//  WeatherTask
//
//  Created by Michael Winkler on 15.02.25.
//


import SwiftUI
import Combine

@MainActor
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
    
    var registerButtonBackgroundColor: Color {
        isRegisterButtonEnabled ? .blue : .gray
    }

    func register() {
        guard isRegisterButtonEnabled else {
            errorMessage = "Please fill in all fields."
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        Task {
            do {
                try await AuthManager.shared.signUp(email: email, password: password)
                isRegistered = true
                errorMessage = nil
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
