//
//  dateBubble.swift
//  MealHub
//
//  Created by Derek Howes on 11/30/23.
//

import SwiftUI

struct DateBubble: View {
    var day: Date
    var selectedDate: Date
    var updatedSelectedDate: @MainActor (Date) -> Void
    
    
    var body: some View {
        VStack {
            ZStack{
                if day.formatted(.dateTime.day().month()) == Date().formatted(.dateTime.day().month()) {
                    Circle()
                        .strokeBorder(brandColors.green, lineWidth: 2)
                        .background(Circle().fill(day == selectedDate ? brandColors.orange : brandColors.warm))
                        .frame(width: 40, height: 40)
                } else {
                    Circle()
                        .fill(day == selectedDate ? brandColors.orange : day.withinTwoWeeks() ? brandColors.warm : brandColors.disabledwarm)
                        .frame(width: 40, height: 40)
                }
                
                Text(day.formatted(.dateTime.day()))
                    .font(.customSystem(size: 14, weight: .semibold))
                    .foregroundColor(day == selectedDate ? .white : .black)
            }
            
            Text(day.formatted(.dateTime.weekday()))
                .font(.customSystem(size: 14, weight: .medium))
                .frame(width: 40, height: 20)
        }
        .onTapGesture {
            withAnimation {
                updatedSelectedDate(day)
            }
        }
    }
}


#Preview {
    DateBubble(day: Date(), selectedDate: Date(), updatedSelectedDate: {_ in})
}
