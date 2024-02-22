//
//  TrashDragLabel.swift
//  MealHub
//
//  Created by Derek Howes on 12/21/23.
//

import SwiftUI

struct TrashLabel: View {
    var offset: CGSize
    
    var body: some View {
        Image("custom.trash")
            .resizable()
            .scaledToFit()
            .frame(width: 20)
            .foregroundColor(brandColors.offWhite)
            .background(
                Rectangle()
                    .fill(.red)
                    .frame(width: 40, height: 30)
            )
            .offset(x: offset.width/2 + 20)
    }
}

#Preview {
    TrashLabel(offset: CGSize.zero)
}
