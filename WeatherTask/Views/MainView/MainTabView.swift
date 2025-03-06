//
//  MainTabView.swift
//  WeatherTask
//
//  Created by Michael Winkler on 17.02.25.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        TabView {
            TabViewItem(
                tabTitle: "Home", 
                tabImage: "house.fill"
            ) {
                MainView()
            }
            
            TabViewItem(
                tabTitle: "Settings", 
                tabImage: "gearshape.fill"
            ) {
                SettingsView()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MainTabView()
}
