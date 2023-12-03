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
            Text("Groceries")
                .tabItem {
                    Label("Groceries", systemImage: "takeoutbag.and.cup.and.straw")
                }
            Text("Resources")
                .tabItem {
                    Label("Resources", systemImage: "fork.knife")
                }
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
        }
        .padding(0)
        .ignoresSafeArea()
        .environmentObject(tempFoodAccess)
    }
}

#Preview {
    NavView()
}
