//
//  ResourcesVew.swift
//  Food@Home
//
//  Created by Derek Howes on 1/27/24.
//

import SwiftUI

struct ResourcesView: View {
    @State private var showTabBar: Bool  = false

    var body: some View {
        subViewHeader(headerText: "Resources")

        VStack {
            VStack(spacing: 24) {
                NavigationLink(destination: GuideTemplate(articleInfo: mealPrepGuide)) {
                    ResourceOptionView(title: "How to use the meal prep guide", subText: "3 simple steps")
                }
                .buttonStyle(.plain)
                
                NavigationLink(destination: GuideTemplate(articleInfo: makeAMealGuide)) {
                    ResourceOptionView(title: "What makes a meal?", subText: "Some tips on balancing your food categories")
                }
                .buttonStyle(.plain)
                
                NavigationLink(destination: GuideTemplate(articleInfo: wellBalancedMeal)) {
                    ResourceOptionView(title: "Create a well balanced meal", subText: "Check out my plate resources")
                }
                .buttonStyle(.plain)
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden(true)
        .toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
    }
}

#Preview {
    ResourcesView()
}


