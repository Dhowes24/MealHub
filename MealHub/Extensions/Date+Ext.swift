//
//  Date+Ext.swift
//  MealHub
//
//  Created by Derek Howes on 2/21/24.
//

import Foundation
import SwiftUI

extension Date {
    
    
    func isSameDay(as date: Date) -> Bool {
        let calendar = Calendar.current
        let formattedSelf = calendar.dateComponents([.month, .day], from: self)
        let compareToDate = calendar.dateComponents([.month, .day], from: date)
        
        return formattedSelf.month == compareToDate.month && formattedSelf.day == compareToDate.day
    }

    
    func isSameMonth(as date: Date) -> Bool {
        let calendar = Calendar.current
        let formattedSelf = calendar.dateComponents([.month], from: self)
        let compareToDate = calendar.dateComponents([.month], from: date)
        
        return formattedSelf.month == compareToDate.month
    }

    
    func withinTwoWeeks() -> Bool  {
        let range = Calendar.current.startOfDay(for: Date())...Date().addingTimeInterval(TimeInterval(86400 * 13))
        return range ~= self
    }

}
