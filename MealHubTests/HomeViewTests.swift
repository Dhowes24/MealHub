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
    
    
    @MainActor func test_getDateLineup() throws {
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
    
    
    @MainActor func test_updateSelectDate() throws {
        // Given
        for day in 0..<4 {
            
            // When
            let timeInterval = Date.distantFuture.timeIntervalSince(Date.distantPast)
            let randomInterval = Double.random(in: 0...100)
            let randomDate = Date.distantPast.addingTimeInterval(randomInterval)
            testViewModel.updateSelectedDate(newDate: randomDate)
            
            //Then
            var vmDate = testViewModel.selectedDate
            XCTAssertTrue(vmDate == randomDate)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
