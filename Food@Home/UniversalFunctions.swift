//
//  UniversalFunctions.swift
//  Food@Home
//
//  Created by Derek Howes on 1/10/24.
//

import Foundation
import SwiftUI

func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
    let calendar = Calendar.current
    let components1 = calendar.dateComponents([.month, .day], from: date1)
    let components2 = calendar.dateComponents([.month, .day], from: date2)
    
    return components1.month == components2.month && components1.day == components2.day
}

func isSameMonth(_ date1: Date, _ date2: Date) -> Bool {
    let calendar = Calendar.current
    let components1 = calendar.dateComponents([.month], from: date1)
    let components2 = calendar.dateComponents([.month], from: date2)
    
    return components1.month == components2.month
}

func withinDateRange(_ date: Date) -> Bool  {
    let range = Calendar.current.startOfDay(for: Date())...Date().addingTimeInterval(TimeInterval(86400 * 13))
    return range ~= date
}
