//
//  Logo.swift
//  MealHub
//
//  Created by Derek Howes on 11/5/23.
//

import SwiftUI

struct Logo: View {
    var frameSize: CGFloat
    
    var body: some View {
        Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
            .resizable()
            .scaledToFit()
            .clipShape(
                Circle()
            )
            .frame(width: frameSize,height: frameSize)
    }
}

#Preview {
    Logo(frameSize: 180)
}
