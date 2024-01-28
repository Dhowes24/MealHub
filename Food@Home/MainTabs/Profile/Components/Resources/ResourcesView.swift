//
//  ResourcesVew.swift
//  Food@Home
//
//  Created by Derek Howes on 1/27/24.
//

import SwiftUI

struct ResourcesView: View {
    
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
                
                Text ("Resources")
                    .font(.customSystem(size: 32, weight: .bold))
                
                Spacer()
                
                Rectangle()
                    .frame(width: 24, height: 24)
                    .opacity(0.0)
            }
            .padding(.top, 31)
            .padding(.bottom, 13)
            
            VStack(spacing: 24) {
                ResourceOptionView(title: "How to use the meal prep guide", subText: "3 simple steps")
                
                ResourceOptionView(title: "What makes a meal?", subText: "Some tips on balancing your food categories")
                
                ResourceOptionView(title: "Create a well balanced meal", subText: "Check out my plate resources")
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


