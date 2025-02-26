//
//  LoginView.swift
//  WeatherTask
//
//  Created by Michael Winkler on 14.02.25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()

                if viewModel.isUserSignedIn {
                    // Bereits eingeloggt Meldung + Navigation
                    AlrdySignedIn()
                } else {
                    // Login-Formular anzeigen, wenn nicht eingeloggt
                    TextField("E-Mail", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)

                    HStack {
                        if viewModel.isPasswordVisible {
                            TextField("Passwort", text: $viewModel.password)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        } else {
                            SecureField("Passwort", text: $viewModel.password)
                                .textContentType(.password)
                        }

                        Button(action: {
                            viewModel.isPasswordVisible.toggle()
                        }) {
                            Image(systemName: viewModel.isPasswordVisible ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                    }

                    Button(action: {
                        Task {
                            do {
                                try await viewModel.signIn()
                                viewModel.isLoginSuccessful = true // Erfolgreicher Login -> Navigation zur SuccessView
                            } catch {
                                viewModel.errorMessage = "Login fehlgeschlagen: \(error.localizedDescription)"
                            }
                        }
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.loginButtonBackgroundColor)
                            .cornerRadius(8)
                    }
                    .disabled(!viewModel.isLoginButtonEnabled)

                    NavigationLink("Registrieren", destination: RegistrationView())
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $viewModel.isLoginSuccessful) {
                SuccessView(successMessage: "Login erfolgreich!")
            }
        }
    }
}

#Preview {
    LoginView()
}
