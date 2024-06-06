//
//  HomeViewTests.swift
//  MealHubTests
//
//  Created by Derek Howes on 3/30/24.
//

import XCTest
import Foundation
@testable import MealHub

final class HomeViewTests: XCTestCase {
    
    var testViewModel: HomeViewModel!
    let calendar = Calendar.current
    
    
    @MainActor override func setUpWithError() throws {
        super.setUp()
        testViewModel = HomeViewModel()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    @MainActor func test_getDateLineup_basic() throws {
        // Given
        let startDate = Date()
        
        // When
        
        // Then
        let dateLineup = testViewModel.dateLineup
        print(dateLineup)
        for day in 0..<7 {
            if let testDate = calendar.date(byAdding: .day, value: day, to: startDate) {
                let containsDate = dateLineup.contains { calendar.isDate($0, inSameDayAs: testDate) }
                
                XCTAssertTrue(containsDate)
            }
        }
    }
    
    
    @MainActor func test_getDateLineup_specificDate() throws {
        // Given
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let startDate = formatter.date(from: "2023/06/01")!
        
        // When
        let dateLineup = testViewModel.getDateLineup(startDate: startDate)
        
        
        // Then
        let expectedDates = (0..<7).compactMap { day in
            calendar.date(byAdding: .day, value: day, to: startDate)
        }
        
        XCTAssertEqual(dateLineup.count, expectedDates.count)
        for expectedDate in expectedDates {
            let containsDate = dateLineup.contains { calendar.isDate($0, inSameDayAs: expectedDate) }
            XCTAssertTrue(containsDate)
        }
    }
    
    
    @MainActor func test_getDateLineup_endOfMonth() throws {
        // Given
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let startDate = formatter.date(from: "2023/01/28")!
        
        // When
        let dateLineup = testViewModel.getDateLineup(startDate: startDate)
        
        // Then
        let expectedDates = (0..<7).compactMap { day in
            calendar.date(byAdding: .day, value: day, to: startDate)
        }
        
        XCTAssertEqual(dateLineup.count, expectedDates.count)
        for expectedDate in expectedDates {
            let containsDate = dateLineup.contains { calendar.isDate($0, inSameDayAs: expectedDate) }
            XCTAssertTrue(containsDate)
        }
    }
    
    
    @MainActor func test_updateSelectDate() throws {
        // Given
        for _ in 0..<4 {
            
            // When
            let randomInterval = Double.random(in: 0...365)
            let randomDate = Date.distantPast.addingTimeInterval(randomInterval)
            testViewModel.updateSelectedDate(newDate: randomDate)
            
            //Then
            let vmDate = testViewModel.selectedDate
            XCTAssertTrue(vmDate == randomDate)
        }
    }
    
    
    @MainActor func test_updateWeekLineup_followingWeek() throws {
        //Given
        let randomInterval = Double.random(in: 0...365)
        let randomDate = Date.distantPast.addingTimeInterval(randomInterval)
        testViewModel.dateLineup =  testViewModel.getDateLineup(startDate: randomDate)
        let initialFirstDate = testViewModel.dateLineup[0]
        let followingWeek = 1
        
        //When
        testViewModel.updateWeekLineup(direction: followingWeek)
        
        //Then
        let newSelectedDate = testViewModel.selectedDate
        XCTAssertTrue(calendar.date(byAdding: .day, value: 7, to: initialFirstDate) == newSelectedDate)
    }
    
    
    @MainActor func test_updateWeekLineup_previousWeek() throws {
        //Given
        let randomInterval = Double.random(in: 0...365)
        let randomDate = Date.distantPast.addingTimeInterval(randomInterval)
        testViewModel.dateLineup =  testViewModel.getDateLineup(startDate: randomDate)
        let initialFirstDate = testViewModel.dateLineup[0]
        let previousWeek = -1
        
        //When
        testViewModel.updateWeekLineup(direction: previousWeek)
        
        //Then
        let newSelectedDate = testViewModel.selectedDate
        XCTAssertTrue(calendar.date(byAdding: .day, value: -1, to: initialFirstDate) == newSelectedDate)
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
