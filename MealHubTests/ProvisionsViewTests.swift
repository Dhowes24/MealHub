//
//  ProvisionsViewTests.swift
//  MealHubTests
//
//  Created by Derek Howes on 6/5/24.
//

import XCTest
import CoreData
import Foundation
@testable import MealHub


final class ProvisionsViewTests: XCTestCase {
    
    var testViewModel: ProvisionsViewModel?
    var context: NSManagedObjectContext?
    var mockController: PersistenceController!
    
    @MainActor override func setUpWithError() throws {
        super.setUp()
        mockController = PersistenceController.shared
        self.testViewModel = ProvisionsViewModel(persistenceController: mockController)
    }
    
    
    override func tearDownWithError() throws {
        super.tearDown()
        mockController = nil
        context = nil
    }
    
    
    @MainActor func test_addItem_basic() {
        //Given
        let date = Date()
        let itemName = "item name"
        let owned = Bool.random()
        
        //When
        self.testViewModel?.addItem(dateAdded: date, name: itemName, owned: owned)
        
        //Then
        do {
            try self.context?.performAndWait {
                let request = NSFetchRequest<FoodItem>(entityName: "FoodItem")
                request.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: true)]
                let fetchResults = try context?.fetch(request) as! [FoodItem]
                XCTAssertEqual(fetchResults.count, 1)
                XCTAssertEqual(fetchResults[0].dateAdded, date)
                XCTAssertEqual(fetchResults[0].name, itemName)
                XCTAssertEqual(fetchResults[0].owned, owned)
            }
        } catch {
            NSLog("Error while fetching data")
        }
    }
    
    @MainActor func test_allItemsSelected() {
        //Given
        let allItemsSelected: [FoodItem:Bool] = [FoodItem(): true, FoodItem(): true]
        let partialItemsSelected: [FoodItem:Bool] = [FoodItem(): true, FoodItem(): false]
        let noItemsSelected: [FoodItem:Bool] = [FoodItem(): false, FoodItem(): false]

        //When
        let allSelected = testViewModel?.allItemsSelected(toggleItems: allItemsSelected)
        let partialSelected = testViewModel?.allItemsSelected(toggleItems: partialItemsSelected)
        let noSelected = testViewModel?.allItemsSelected(toggleItems: noItemsSelected)
        
        //Then
        XCTAssertTrue(allSelected!)
        XCTAssertFalse(partialSelected!)
        XCTAssertFalse(noSelected!)
    }
    
    
    @MainActor func test_itemsSelected() {
        //Given
        let allItemsSelected: [FoodItem:Bool] = [FoodItem(): true, FoodItem(): true]
        let partialItemsSelected: [FoodItem:Bool] = [FoodItem(): true, FoodItem(): false]
        let noItemsSelected: [FoodItem:Bool] = [FoodItem(): false, FoodItem(): false]

        //When
        let allSelected = testViewModel?.itemsSelected(toggleItems: allItemsSelected)
        let partialSelected = testViewModel?.itemsSelected(toggleItems: partialItemsSelected)
        let noSelected = testViewModel?.itemsSelected(toggleItems: noItemsSelected)
        
        //Then
        XCTAssertTrue(allSelected!)
        XCTAssertTrue(partialSelected!)
        XCTAssertFalse(noSelected!)
    }
    
    @MainActor func test_moveOrDeleteItems_delete() {
        //Given
        let date = Date()
        let itemName1 = "item name1"
        let itemName2 = "item name1"
        let owned = true
        
        //When
        self.testViewModel?.addItem(dateAdded: date, name: itemName1, owned: owned)
        self.testViewModel?.addItem(dateAdded: date, name: itemName2, owned: owned)
        
        //Then
        do {
            try self.context?.performAndWait {
                let request = NSFetchRequest<FoodItem>(entityName: "FoodItem")
                request.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: true)]
                let fetchResults = try context?.fetch(request) as! [FoodItem]
                let FoodItem1 = fetchResults[0]
                let FoodItem2 = fetchResults[1]
                XCTAssertEqual(fetchResults.count, 2)

                
                var selectedItem: [FoodItem: Bool] = [FoodItem1: true, FoodItem2: true]
                testViewModel?.moveOrDeleteItems(deleting: true, toggleItems: &selectedItem)
                XCTAssertEqual(selectedItem.count, 0)
                XCTAssertEqual(fetchResults.count, 0)

            }
        } catch {
            NSLog("Error while fetching data")
        }
    }
    
    
    @MainActor func test_moveOrDeleteItems_move() {
        //Given
        let date = Date()
        let itemName1 = "item name1"
        let itemName2 = "item name1"
        let owned = false
        
        //When
        self.testViewModel?.addItem(dateAdded: date, name: itemName1, owned: owned)
        self.testViewModel?.addItem(dateAdded: date, name: itemName2, owned: owned)
        
        //Then
        do {
            try self.context?.performAndWait {
                let request = NSFetchRequest<FoodItem>(entityName: "FoodItem")
                request.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: true)]
                var fetchResults = try context?.fetch(request) as! [FoodItem]
                let FoodItem1 = fetchResults[0]
                let FoodItem2 = fetchResults[1]
                
                var selectedItem: [FoodItem: Bool] = [FoodItem1: true, FoodItem2: true]
                testViewModel?.moveOrDeleteItems(deleting: false, toggleItems: &selectedItem)
                fetchResults = try context?.fetch(request) as! [FoodItem]

                fetchResults.forEach({ FoodItem in
                    XCTAssertTrue(FoodItem.owned)
                })

            }
        } catch {
            NSLog("Error while fetching data")
        }
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
