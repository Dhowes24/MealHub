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

#Preview {
    Header(headerText: "Welcome!")
}
