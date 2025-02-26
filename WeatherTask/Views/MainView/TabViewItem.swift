//
//  TabViewItem.swift
//  WeatherTask
//
//  Created by Michael Winkler on 17.02.25.
//


import SwiftUI

struct TabViewItem<Content: View>: View {
    var tabTitle: String
    var tabImage: String
    var content: Content
    
    init(tabTitle: String, tabImage: String, @ViewBuilder content: () -> Content) {
        self.tabTitle = tabTitle
        self.tabImage = tabImage
        self.content = content()
    }
    
    var body: some View {
        content
            .tabItem {
                Label(tabTitle, systemImage: tabImage)
            }
    }
}

#Preview {
    TabView {
        TabViewItem(tabTitle: "Test", tabImage: "house", content: { Text("Test") })
    }
}
