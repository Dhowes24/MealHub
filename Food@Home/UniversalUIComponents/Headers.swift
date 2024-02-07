//
//  Header.swift
//  Food@Home
//
//  Created by Derek Howes on 11/30/23.
//

import SwiftUI

struct Header: View {
    var headerText: String
    
    var body: some View {
        HStack {
            Text(headerText)
                .font(.customSystem(size: 32, weight: .semibold))
            
            Spacer()
            
            Logo(frameSize: 48)
            
        }
        .padding(.top, 40)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

struct subViewHeader: View {
    @Environment(\.dismiss) private var dismiss
    var headerText: String
    var path: NavigationPath
    @Binding var showTabBar: Bool
    
    init(headerText: String, path: NavigationPath = NavigationPath(), showTabBar: Binding<Bool> = .constant(true)) {
        self.headerText = headerText
        self.path = path
        self._showTabBar = showTabBar
        
    }

    var body: some View {
        HStack {
            Image(systemName: "arrow.backward")
                .frame(width: 24, height: 24)
                .onTapGesture {
                    dismiss()
                    if path.count <= 1 {
                        showTabBar = true
                    }
                }
            
            Spacer()
            
            Text(headerText)
                .font(.customSystem(size: 30, weight: .bold))
            
            Spacer()
            
            Rectangle()
                .frame(width: 24, height: 24)
                .opacity(0.0)
        }
        .padding(.top, 31)
        .padding(.bottom, 13)
        .padding(.horizontal, 16)
    }
}
