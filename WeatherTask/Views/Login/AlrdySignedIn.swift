//
//  AlrdySignedIn.swift
//  WeatherTask
//
//  Created by Michael Winkler on 19.02.25.
//

import SwiftUI

struct AlrdySignedIn: View {
    var body: some View {
        Text("✅ Sie sind bereits eingeloggt!")
            .foregroundColor(.green)
            .font(.title2)
            .bold()

        NavigationLink("Weiter", destination: MainTabView())
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

#Preview {
    AlrdySignedIn()
}
