//
//  FoodProfileView.swift
//  Food@Home
//
//  Created by Derek Howes on 1/27/24.
//

import SwiftUI

struct FoodProfileView: View {
    
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
                
                Text ("Food Profile")
                    .font(.customSystem(size: 18, weight: .bold))
                
                Spacer()
                
                Rectangle()
                    .frame(width: 24, height: 24)
                    .opacity(0.0)
            }
            .padding(.top, 31)
            .padding(.bottom, 13)
            
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
