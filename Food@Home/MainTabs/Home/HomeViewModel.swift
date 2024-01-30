//
//  HomeViewModel.swift
//  Food@Home
//
//  Created by Derek Howes on 11/30/23.
//

import CoreData
import Foundation
import SwiftUI

@MainActor class HomeViewModel: ObservableObject {
    @Published var dateLineup: [Date] = []
    @Published var selectedDate: Date = Date()
    @Published var path = NavigationPath()
    
    init() {
        self.dateLineup = getDateLineup(startDate: Date())
        self.selectedDate = dateLineup[0]
    }
    
    func deleteScheduledMeal(moc: NSManagedObjectContext, meal: RecipeCD) {
        moc.delete(meal)
        try? moc.save()
    }
    
    func getDateLineup(startDate: Date) -> [Date] {
        var dates: [Date] = []
        let calendar = Calendar.current
        
        for day in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: day, to: startDate) {
                dates.append(date)
            }
        }
        
        return dates
    }
    
    func updateSelectedDate(newDate: Date) {
        selectedDate = newDate
    }
    
    func updateWeekLineup(direction: Int) {
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .day, value: 7 * direction, to: dateLineup[0]) {
            dateLineup = getDateLineup(startDate: newDate)
            selectedDate = dateLineup[0]
        }
    }
}

