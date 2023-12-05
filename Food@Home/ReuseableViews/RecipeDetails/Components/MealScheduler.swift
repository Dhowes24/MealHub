//
//  MealScheduler.swift
//  Food@Home
//
//  Created by Derek Howes on 12/1/23.
//

import SwiftUI

struct MealScheduler: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            HStack {
                Image(systemName: "arrow.backward")
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        dismiss()
                    }
                Spacer()
                
                Text("Schedule Meal")
                    .font(.customSystem(size: 18, weight: .heavy))
                    .frame(width: 245, height: 24)
                
                Spacer()
                
                Rectangle()
                    .fill(.clear)
                    .frame(width: 24, height: 24)
            }
            .padding(.top, 31)
            .padding(.bottom, 13)
            
        }
        .padding(.horizontal, 17)
        
        SeparatorLine()
        
        VStack {
            Text("Select the meal times you'd like to schedule your meal for.")
                .font(.customSystem(size: 16, weight: .regular))
                .padding(.vertical, 24)
            
            SeparatorLine()
        }
        .padding(.horizontal, 17)
        
        Spacer()
        
        SeparatorLine()
        
        Text("Done")
            .button(color: "black")
            .onTapGesture {
                dismiss()
            }
            .padding(.vertical, 8)
    }
}

#Preview {
    MealScheduler()
}
