//
//  SuccessView 2.swift
//  WeatherTask
//
//  Created by Michael Winkler on 19.02.25.
//


//
//  SuccessView.swift
//  WeatherTask
//
//  Created by Michael Winkler on 15.02.25.
//

import SwiftUI

struct RegistrationSuccessView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)

            Text("Erfolgreich registriert!")
                .font(.title)
                .bold()

            Text("Dein Account wurde erfolgreich erstellt. Du kannst jetzt loslegen.")
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
    RegistrationSuccessView()
}
