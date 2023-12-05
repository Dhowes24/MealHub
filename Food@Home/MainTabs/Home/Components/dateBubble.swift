//
//  dateBubble.swift
//  Food@Home
//
//  Created by Derek Howes on 11/30/23.
//

import SwiftUI

struct dateBubble: View {
    var day: Date
    var selectedDate: Date
    var updatedSelectedDate: @MainActor (Date) -> Void
    var body: some View {
        VStack {
            ZStack{
                Circle()
                    .fill(day == selectedDate ? brandOrange : brandWarm)
                    .frame(width: 40, height: 40)
                
                Text(day.formatted(.dateTime.day()))
                    .font(.customSystem(size: 14, weight: .semibold))
                    .foregroundColor(day == selectedDate ? .white : .black)
            }
            Text(day.formatted(.dateTime.weekday()))
                .font(.customSystem(size: 14, weight: .medium))
                .frame(width: 40, height: 20)

        }
        .onTapGesture {
            updatedSelectedDate(day)
        }
    }
}

#Preview {
    dateBubble(day: Date(), selectedDate: Date(), updatedSelectedDate: {_ in})
}
