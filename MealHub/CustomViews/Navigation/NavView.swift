//
//  TabView.swift
//  MealHub
//
//  Created by Derek Howes on 10/4/23.
//

import SwiftUI

struct NavView: View {
    @State private var selectedTab: Int = 0
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", image: selectedTab == 0 ? "custom.home.active" : "custom.home.inactive")
                }
                .tag(0)
            ProvisionsView()
                .tabItem {
                    Label("Provisions", image: "custom.provisions")
                }
                .tag(1)
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(2)
        }
        .tint(.black)
        .ignoresSafeArea()
    }
}


#Preview {
    NavView()
}
