//
//  LoginViewModel.swift
//  WeatherTask
//
//  Created by Michael Winkler on 14.02.25.
//

import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?

    private let errorHandler = ErrorHandler()

    var isLoginButtonEnabled: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    var loginButtonBackgroundColor: Color {
        isLoginButtonEnabled ? .blue : .gray
    }

    func login() {
        guard isValidEmail(email) else {
            errorHandler.handle(error: AuthError.invalidEmail)
            errorMessage = errorHandler.errorMessage
            return
        }

        Task {
            do {
                try await AuthManager.shared.signIn(email: email, password: password)
                isLoggedIn = true
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
