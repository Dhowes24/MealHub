//
//  TabView.swift
//  Food@Home
//
//  Created by Derek Howes on 10/4/23.
//

import SwiftUI

struct NavView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            ProvisionsView()
                .tabItem {
                    Label("Provisions", systemImage: "takeoutbag.and.cup.and.straw")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NavView()
}
