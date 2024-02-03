//
//  FoodProfileView.swift
//  Food@Home
//
//  Created by Derek Howes on 1/27/24.
//

import SwiftUI

struct FoodProfileView: View {
    @State private var showTabBar: Bool  = false
    
    var body: some View {
        subViewHeader(headerText: "Food Profile")
        
        VStack {
            FoodProfileOption(title: "Intolerances")
            FoodProfileOption(title: "Dietary Need")
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden(true)
        .toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
    }
}

#Preview {
    FoodProfileView()
}
