//
//  TabView.swift
//  MealHub
//
//  Created by Derek Howes on 10/4/23.
//

import SwiftUI

struct NavView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    selectedTab == 0 ? navigationLabels.homeActive : navigationLabels.homeInactive
                }
                .tag(0)
            ProvisionsView()
                .tabItem {
                    navigationLabels.provisions
                }
                .tag(1)
            ProfileView()
                .tabItem {
                    navigationLabels.profile
                }
                .tag(2)
        }
        .tint(brandColors.tint.scheme(colorScheme))
        .ignoresSafeArea()

    }
}


#Preview {
    NavView()
}
