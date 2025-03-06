//
//  RegistrationView.swift
//  WeatherTask
//
//  Created by Michael Winkler on 15.02.25.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject private var viewModel = RegistrationViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Register")
                    .font(.largeTitle)
                    .bold()

                CustomTextField(
                    placeholder: "E-Mail",
                    text: $viewModel.email,
                    isSecure: false,
                    isPasswordVisible: .constant(false)
                )
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

                CustomTextField(
                    placeholder: "Password",
                    text: $viewModel.password,
                    isSecure: true,
                    showToggle: true,
                    isPasswordVisible: $viewModel.isPasswordVisible
                )

                CustomTextField(
                    placeholder: "Confirm Password",
                    text: $viewModel.confirmPassword,
                    isSecure: true,
                    showToggle: true,
                    isPasswordVisible: $viewModel.isConfirmPasswordVisible
                )

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                }

                Button(action: {
                    Task {
                        do {
                            try await viewModel.register()
                            viewModel.isRegistrationSuccessful = true // Erfolgreiche Registrierung setzen
                        } catch {
                            viewModel.errorMessage = "Registration failed: \(error.localizedDescription)"
                        }
                    }
                }) {
                    Text("Register")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.isRegisterButtonEnabled ? Color.blue : Color.gray)
                        .cornerRadius(8)
                }
                .disabled(!viewModel.isRegisterButtonEnabled)
                .padding(.top, 10)
                // Navigation zur SuccessView bei erfolgreicher Registrierung
                .navigationDestination(isPresented: $viewModel.isRegistrationSuccessful) {
                    SuccessView(successMessage: "Registration erfolgreich!")}

                NavigationLink(destination: LoginView()) {
                    Text("Back to Login")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    RegistrationView()
}
