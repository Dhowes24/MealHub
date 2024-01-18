//
//  TabView.swift
//  Food@Home
//
//  Created by Derek Howes on 10/4/23.
//

import SwiftUI

struct NavView: View {
    @StateObject var tempFoodAccess: FoodItemsAccess = FoodItemsAccess()

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
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
        }
        .ignoresSafeArea()
        .environmentObject(tempFoodAccess)
    }
}

#Preview {
    NavView()
}
