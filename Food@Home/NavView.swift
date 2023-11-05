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
            KitchenTestView()
                .tabItem {
                    Label("Kitchen", systemImage: "fork.knife")
                }
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "graduationcap")
                }
            Text("Planner")
                .tabItem {
                    Label("Planner", systemImage: "calendar")
                }
            AccountTestView()
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