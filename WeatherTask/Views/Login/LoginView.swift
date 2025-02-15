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

                TextField("E-Mail", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                HStack {
                    if viewModel.isPasswordVisible {
                        TextField("Password", text: $viewModel.password)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    } else {
                        SecureField("Password", text: $viewModel.password)
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
                    viewModel.login()
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.loginButtonBackgroundColor)
                        .cornerRadius(8)
                }
                .disabled(!viewModel.isLoginButtonEnabled)
                .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                    Text("MainView")
                }

                NavigationLink("Register", destination: RegistrationView())
                    .foregroundColor(.blue)
            }
            .padding()
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    LoginView()
}
