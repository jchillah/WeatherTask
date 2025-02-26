//
//  RegistrationViewModel.swift
//  WeatherTask
//
//  Created by Michael Winkler on 15.02.25.
//


import SwiftUI
import Combine
import os

@MainActor
class RegistrationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var isConfirmPasswordVisible: Bool = false
    @Published var errorMessage: String?
    @Published var isRegistered: Bool = false
    @Published var user: User?
    @Published var isRegistrationSuccessful = false


    private let userRepository = UserRepository()
    private let authManager = AuthManager.shared
    private let logger = Logger(subsystem: "com.weathertask.app", category: "RegistrationViewModel")
    
    var isRegisterButtonEnabled: Bool {
        !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty
    }

    func signUp() {
        Task {
            do {
                try await AuthManager.shared.signUp(email: email, password: password)
                let userID = AuthManager.shared.userID!
                let email = AuthManager.shared.email!
                self.user = try await userRepository.insert(id: userID, email: email, createdOn: .now)
                errorMessage = nil
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    func register() async throws{
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

            do {
                try await authManager.signUp(email: email, password: password)
                let userID = AuthManager.shared.userID!
                let email = AuthManager.shared.email!
                self.user = try await userRepository.insert(id: userID, email: email, createdOn: .now)
                errorMessage = nil
                isRegistered = true
                logger.info("User successfully registered")
            } catch {
                let errorMsg = handleAuthError(error)
                errorMessage = errorMsg
                logger.error("Registration failed: \(errorMsg)")
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
