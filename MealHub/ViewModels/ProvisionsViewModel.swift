//
//  ProvisionsViewModel.swift
//  MealHub
//
//  Created by Derek Howes on 1/9/24.
//

import CoreData
import Foundation

@MainActor class ProvisionsViewModel: ObservableObject {
    let mainContext: NSManagedObjectContext
    let persistenceController: PersistenceController
    @Published var myKitchenShowing: Bool  = true
    @Published var newItemName: String = ""
    @Published var items: [FoodItem] = []

    @Published var selectAllBool: Bool = false
    @Published var triggerRefresh: Bool = false
    
    init(persistenceController: PersistenceController = PersistenceController.shared) {
        self.mainContext = persistenceController.mainContext
        self.persistenceController = persistenceController
        refreshItems()
    }
    
    
     func addItem(dateAdded: Date, name: String, owned: Bool) {
        persistenceController.addFoodItem(dateAdded: dateAdded, name: name, owned: owned)
        refreshItems()
    }
    
    
    func allItemsSelected(toggleItems: [FoodItem: Bool]) -> Bool {
        !toggleItems.values.contains { Bool in Bool == false }
    }
    
    
    func itemsSelected(toggleItems: [FoodItem: Bool]) -> Bool {
        toggleItems.values.contains { Bool in Bool == true }
    }
    
    
    func moveOrDeleteItems( deleting: Bool = true, toggleItems: inout [FoodItem: Bool]) {
        var actionItemsArray: [FoodItem] = []
        
        toggleItems.forEach { (key: FoodItem, value: Bool) in
            if toggleItems[key] ?? false {
                actionItemsArray.append(key)
            }
        }
        if deleting {
            PersistenceController.shared.deleteFoodItems(itemsToDelete: actionItemsArray, allFoodItems: &items)
        } else {
            PersistenceController.shared.moveItemsToKitchen(itemsToMove: actionItemsArray)
        }
        triggerRefresh.toggle()
    }
    

    func refreshItems() {
        let request = NSFetchRequest<FoodItem>(entityName: "FoodItem")
        
        do {
            let tempItems = try mainContext.fetch(request)
            
            items = tempItems.sorted(by: {
                if $0.dateAdded! ==  $1.dateAdded! {
                    return true
                } else {
                    return $0.dateAdded! < $1.dateAdded!
                }
            })
            
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    
    func refreshPage(ownedItems: Bool, toggleItems: inout [FoodItem: Bool]) {
        let tempItems = toggleItems
        toggleItems.removeAll()
        
        let filteredItems = items.filter { $0.owned == ownedItems }
        filteredItems.forEach { item in
            if tempItems.keys.contains(item) {
                toggleItems[item] = tempItems[item]
            } else {
                toggleItems[item] = false
            }
        }
    }
    
    
    func selectAll(_ bool: Bool, toggleItems: inout [FoodItem: Bool]) {
        selectAllBool = bool
        for (key,_) in toggleItems {
            toggleItems[key] = bool
        }
    }
}
