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

    private let authManager = AuthManager.shared
    
    var isRegisterButtonEnabled: Bool {
        !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty
    }

    func register() {
        guard isRegisterButtonEnabled else {
            errorMessage = "Please fill in all fields."
            return
        }

        guard EmailValidator.isValid(email) else {
            errorMessage = "Invalid email format."
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        Task {
            do {
                try await authManager.signUp(email: email, password: password)
                isRegistered = true
                errorMessage = nil
            } catch {
                errorMessage = handleAuthError(error)
            }
        }
    }
    
    private func handleAuthError(_ error: Error) -> String {
        if let authError = error as? AuthError {
            return authError.localizedDescription
        } else {
            return "An unexpected error occurred."
        }
    }
}
