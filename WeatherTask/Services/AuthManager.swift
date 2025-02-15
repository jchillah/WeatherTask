//
//  AuthManager.swift
//  WeatherTask
//
//  Created by Michael Winkler on 15.02.25.
//

import FirebaseAuth

final class AuthManager {
    static let shared = AuthManager()

    private init() {}

    var isUserSignedIn: Bool {
        Auth.auth().currentUser != nil
    }

    var userID: String? {
        Auth.auth().currentUser?.uid
    }

    var email: String? {
        Auth.auth().currentUser?.email
    }

    func signUp(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            #if DEBUG
            print("User registered: \(result.user.uid)")
            #endif
        } catch let error as NSError {
            throw mapFirebaseAuthError(error)
        }
    }

    func signIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            #if DEBUG
            print("User signed in: \(result.user.uid)")
            #endif
        } catch let error as NSError {
            throw mapFirebaseAuthError(error)
        }
    }

    func signOut() throws {
        do {
            try Auth.auth().signOut()
            #if DEBUG
            print("User signed out")
            #endif
        } catch {
            throw AuthError.unknownError
        }
    }

    private func mapFirebaseAuthError(_ error: NSError) -> AuthError {
        switch error.code {
        case AuthErrorCode.invalidEmail.rawValue:
            return .invalidEmail
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            return .emailAlreadyInUse
        case AuthErrorCode.weakPassword.rawValue:
            return .weakPassword
        case AuthErrorCode.networkError.rawValue:
            return .networkError
        case AuthErrorCode.wrongPassword.rawValue, AuthErrorCode.userNotFound.rawValue:
            return .incorrectCredentials
        default:
            return .unknownError
        }
    }
}
