//
//  myKitchenItems.swift
//  Food@Home
//
//  Created by Derek Howes on 1/10/24.
//

import SwiftUI

struct myKitchenItem: View {
    var isFirst: Bool
    var item: String
    
    var body: some View {
        if !isFirst {
            SeparatorLine()
        }
        
        HStack {
            Text(item)
                .font(.customSystem(size: 16, weight: .semibold))
                .padding(.vertical, 16)
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Image(systemName: "trash")
            }
            )
            .buttonStyle(.plain)
        }
        .frame(height: 55)
    }
}

#Preview {
    myKitchenItem(isFirst: false, item: "Item Name")
}
