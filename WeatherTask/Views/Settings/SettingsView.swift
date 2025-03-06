//
//  SettingsView.swift
//  WeatherTask
//
//  Created by Michael Winkler on 06.03.25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Settings")
            LogoutButtonView(viewModel: LoginViewModel())
            // Weitere Einstellungen...
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
