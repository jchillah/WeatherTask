//
//  LoginViewModel.swift
//  WeatherTask
//
//  Created by Michael Winkler on 14.02.25.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?

    var errorHandler = ErrorHandler()

    var isLoginButtonEnabled: Bool {
        !email.isEmpty && !password.isEmpty
    }

    func login() {
        guard isValidEmail(email) else {
            errorHandler.handle(error: LoginError.invalidEmail)
            errorMessage = errorHandler.errorMessage
            return
        }

        if email == "test@example.com" && password == "password123" {
            isLoggedIn = true
        } else {
            errorHandler.handle(error: LoginError.incorrectCredentials)
            errorMessage = errorHandler.errorMessage
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
