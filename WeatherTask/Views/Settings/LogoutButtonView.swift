//
//  LogoutButtonView.swift
//  WeatherTask
//
//  Created by Michael Winkler on 06.03.25.
//


import SwiftUI

struct LogoutButtonView: View {
    @StateObject var viewModel = LoginViewModel()
    @State private var errorMessage: String? = nil
    
    var body: some View {
        Button(action: {
            Task {
                viewModel.signOut()
            }
        }) {
            Text("Logout")
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(8)
        }
        .alert(item: Binding(get: {
            errorMessage.map { AlertError(message: $0) }
        }, set: { _ in errorMessage = nil })) { alertError in
            Alert(title: Text("Error"), message: Text(alertError.message), dismissButton: .default(Text("OK")))
        }
    }
}

struct AlertError: Identifiable {
    let id = UUID()
    let message: String
}

#Preview {
    LogoutButtonView(viewModel: LoginViewModel())
}
