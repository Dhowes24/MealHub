//
//  TimeSelectorTests.swift
//  MealHubTests
//
//  Created by Derek Howes on 6/7/24.
//

import XCTest
import Foundation
@testable import MealHub
import SwiftUI

final class TimeSelectorTests: XCTestCase {
    
    var testViewModel: TimeSelectorViewModel!
    
    @MainActor override func setUpWithError() throws {
        super.setUp()
        @State var timeSelectorObject = TimeSelectorObject(date: Date())
        
        testViewModel = TimeSelectorViewModel(
            specificDateSelect: {
                return [Date()]
            },
            timeSelectorObject: .constant(timeSelectorObject)
        )
    }
    
    
    @MainActor func test_selectedTimes_selected() {
        //Given
        for i in 1...5 {
            testViewModel.timeSelectorObject.mealTimes["Test"]

        }
        testViewModel.timeSelectorObject.mealTimes = ["Test1": true, "Test2": true, "Test3": true, "Test4": false]
        
        //When
        let result = testViewModel.selectedTimes()
        
        //Then
        testViewModel.timeSelectorObject.mealTimes.forEach({ (key: String, value: Bool) in
            if value {
                XCTAssertTrue(result.range(of: key) != nil)
            } else {
                XCTAssertTrue(result.range(of: key) == nil)
                
            }
        })
    }
    
    
    @MainActor func test_selectedTimes_empty() {
        //Given
        testViewModel.timeSelectorObject.mealTimes = ["Test1": false, "Test2": false, "Test3": false, "Test4": false]
        
        //When
        let result = testViewModel.selectedTimes()
        
        //Then
        XCTAssertTrue(result == "Select meal times")
    }
    
    
    
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
