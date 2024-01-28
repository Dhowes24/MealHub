//
//  SavedRecipesView.swift
//  Food@Home
//
//  Created by Derek Howes on 1/27/24.
//

import SwiftUI

struct SavedRecipesView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var showTabBar: Bool  = false

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.backward")
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        showTabBar = true
                        dismiss()
                    }
                
                Spacer()
                
                Text ("Saved Recipes")
                    .font(.customSystem(size: 18, weight: .bold))
                
                Spacer()
                
                Rectangle()
                    .frame(width: 24, height: 24)
                    .opacity(0.0)
            }
            .padding(.top, 31)
            .padding(.bottom, 13)
            
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
