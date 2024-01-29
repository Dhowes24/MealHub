//
//  UniversalFunctions.swift
//  Food@Home
//
//  Created by Derek Howes on 1/10/24.
//

import Foundation
import SwiftUI

func areSameDate(_ date1: Date, _ date2: Date) -> Bool {
    let calendar = Calendar.current
    let components1 = calendar.dateComponents([.year, .month, .day], from: date1)
    let components2 = calendar.dateComponents([.year, .month, .day], from: date2)

    return components1.year == components2.year &&
           components1.month == components2.month &&
           components1.day == components2.day
}

func withinDateRange(_ date: Date) -> Bool  {
    let range = Calendar.current.startOfDay(for: Date())...Date().addingTimeInterval(TimeInterval(86400 * 13))
    return range ~= date
}
