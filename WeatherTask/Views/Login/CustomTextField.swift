//
//  CustomTextField.swift
//  WeatherTask
//
//  Created by Michael Winkler on 14.02.25.
//

import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var showToggle: Bool = false
    @Binding var isPasswordVisible: Bool

    var body: some View {
        HStack {
            if isSecure && !isPasswordVisible {
                SecureField(placeholder, text: $text)
                    .textContentType(.password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            } else {
                TextField(placeholder, text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }

            if showToggle {
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(8)
    }
}

#Preview {
    @Previewable @State var text = ""
    @Previewable @State var isPasswordVisible = false
    return CustomTextField(
        placeholder: "Passwort",
        text: $text,
        isSecure: true,
        showToggle: true,
        isPasswordVisible: $isPasswordVisible
    )
}
