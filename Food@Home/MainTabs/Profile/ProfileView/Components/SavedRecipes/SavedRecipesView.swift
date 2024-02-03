//
//  SavedRecipesView.swift
//  Food@Home
//
//  Created by Derek Howes on 1/27/24.
//

import SwiftUI

struct SavedRecipesView: View {
    @State private var showTabBar: Bool  = false

    var body: some View {
        subViewHeader(headerText: "Saved Recipes")

        VStack {
                        
            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden(true)
        .toolbar(showTabBar ? .visible : .hidden, for: .tabBar)

    }
}

#Preview {
    SavedRecipesView()
}
