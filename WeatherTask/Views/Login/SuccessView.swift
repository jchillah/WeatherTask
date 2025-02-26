//
//  SuccessView.swift
//  WeatherTask
//
//  Created by Michael Winkler on 17.02.25.
//

import SwiftUI

struct SuccessView: View {
    var successMessage: String

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)

            Text(successMessage)
                .font(.title)
                .bold()

            Text("Du kannst jetzt loslegen.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            NavigationLink(destination: MainTabView()) {
                Text("Weiter")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.top, 20)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SuccessView(successMessage: "Erfolgreich registriert!")
}
