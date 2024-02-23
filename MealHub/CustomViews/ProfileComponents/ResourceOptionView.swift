//
//  ResourceOptionView.swift
//  MealHub
//
//  Created by Derek Howes on 1/28/24.
//

import SwiftUI

struct ResourceOptionView: View {
    var title: String
    var subText: String
    
    var body: some View {
        Group {
            VStack(alignment: .leading) {
                HStack {
                    ZStack {
                        Circle()
                            .foregroundColor(brandColors.orange)
                            .frame(width: 48)
                        
                        SFSymbols.bell
                            .resizable()
                            .frame(width: 21, height: 24)
                    }
                    .padding(.trailing, 16)
                    
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(title)
                            .font(.customSystem(size: 23, weight: .bold))
                        
                        Text(subText)
                            .font(.customSystem(size: 16, weight: .regular))
                            .foregroundStyle(brandColors.darkGrey)
                    }
                }
                .padding(.bottom, 8)
                
                HStack {
                    Spacer()
                    
                    SFSymbols.arrow.getDirection(direction: "forward")
                }
                
            }
            .padding(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16.0)
                    .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.gray)
            )
        }
    }
}

#Preview {
    ResourceOptionView(title: "How to use the meal prep guide", subText: "3 simple steps")
}
