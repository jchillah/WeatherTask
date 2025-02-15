//
//  WeatherTaskApp.swift
//  WeatherTask
//
//  Created by Michael Winkler on 15.02.25.
//

import SwiftUI
import FirebaseCore

@main
struct WeatherTaskApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
