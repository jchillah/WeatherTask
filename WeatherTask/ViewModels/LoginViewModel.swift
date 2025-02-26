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
    @Published var isSignedIn: Bool = false
    @Published var errorMessage: String?
    @Published var navigateToMainTabView = false
    @Published var user: User?
    @Published var isLoginSuccessful = false

    
    private let userRepository = UserRepository()
    private let errorHandler = ErrorHandler()
    
    
    init() {
        _ = AuthManager.shared
        fetchCurrentUser()
    }
    
    var isUserSignedIn: Bool {
        AuthManager.shared.isUserSignedIn
    }

    var isLoginButtonEnabled: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    var loginButtonBackgroundColor: Color {
        isLoginButtonEnabled ? .blue : .gray
    }
        
    private func fetchCurrentUser() {
        Task {
            do {
                if let userID = AuthManager.shared.userID {
                    user = try await userRepository.find(by: userID)
                }
            } catch {
                errorMessage = "The user is not signed in."
            }
        }
    }
    
    func signIn() async throws {
        guard EmailValidator.isValid(email) else {
            errorHandler.handle(error: AuthError.invalidEmail)
            DispatchQueue.main.async {
                self.errorMessage = self.errorHandler.errorMessage
            }
            return
        }
        
        do {
            try await AuthManager.shared.signIn(email: email, password: password)
            let userID = AuthManager.shared.userID!
            let fetchedUser = try await userRepository.find(by: userID)
            
            DispatchQueue.main.async {
                self.user = fetchedUser
                self.isSignedIn = true
                self.errorMessage = nil
                self.navigateToMainTabView = true
            }
        } catch {
            errorHandler.handle(error: error)
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }


    func signOut() {
        Task {
            try? AuthManager.shared.signOut()
            user = nil
        }
    }
}
