//
//  Logo.swift
//  Food@Home
//
//  Created by Derek Howes on 11/5/23.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(brandPink)
                .frame(width: 180, height: 180)
            VStack(spacing: 0) {
                Text("RS")
                    .font(.custom("NotoSerifDisplay-Regular", size: 64))
                    .padding(.vertical, -10)
                Text("RD")
                    .font(.custom("NotoSerifDisplay-Regular", size: 64))
                    .padding(.vertical, -10)
            }
            .frame(width: 115, height: 90)
            .foregroundStyle(brandPurple)
        }
        .frame(width: 180,height: 180)
    }
}

#Preview {
    Logo()
}
