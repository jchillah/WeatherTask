//
//  AuthManager.swift
//  WeatherTask
//
//  Created by Michael Winkler on 15.02.25.
//

import FirebaseAuth

@MainActor
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
            log("User registered: \(result.user.uid)")
        } catch {
            throw handleFirebaseError(error)
        }
    }

    func signIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            log("User signed in: \(result.user.uid)")
        } catch {
            throw handleFirebaseError(error)
        }
    }

    func signOut() throws {
        do {
            try Auth.auth().signOut()
            log("User signed out")
        } catch {
            throw AuthError.unknownError
        }
    }

    private func handleFirebaseError(_ error: Error) -> AuthError {
        guard let errorCode = (error as NSError?)?.code else {
            return .unknownError
        }

        switch errorCode {
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

    private func log(_ message: String) {
        #if DEBUG
        print("[AuthManager] \(message)")
        #endif
    }
}
