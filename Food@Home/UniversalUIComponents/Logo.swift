//
//  Logo.swift
//  Food@Home
//
//  Created by Derek Howes on 11/5/23.
//

import SwiftUI

struct Logo: View {
    var frameSize: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .fill(brandPink)
                .frame(width: frameSize, height: frameSize)
            VStack(spacing: 0) {
                Text("RS")
                    .font(.custom("NotoSerifDisplay-Regular", size: frameSize * 0.35))
                    .padding(.vertical, -frameSize * 0.05)
                Text("RD")
                    .font(.custom("NotoSerifDisplay-Regular", size: frameSize * 0.35))
                    .padding(.vertical, -frameSize * 0.05)
            }
            .frame(width: frameSize * 0.64, height: frameSize * 0.5)
            .foregroundStyle(brandPurple)
        }
        .frame(width: frameSize,height: frameSize)
    }
}

#Preview {
    Logo(frameSize: 180)
}
