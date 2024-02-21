//
//  ProvisionsViewModel.swift
//  MealHub
//
//  Created by Derek Howes on 1/9/24.
//

import CoreData
import Foundation
import SwiftUI

//extension ProvisionsView {
@MainActor class ProvisionsViewModel: ObservableObject {
    let mainContext: NSManagedObjectContext
    @Published var myKitchenShowing: Bool  = true
    @Published var newItemName: String = ""
    @Published var items: [FoodItem] = []
    
    init(mainContext: NSManagedObjectContext = PersistenceController.shared.mainContext) {
        self.mainContext = mainContext
        fetchItems()
    }
    
    func addItem(dateAdded: Date, name: String, owned: Bool) {
        let item = FoodItem(context: mainContext)
        item.dateAdded = dateAdded
        item.id = UUID()
        item.name = name
        item.owned = owned
        
        saveData()
        fetchItems()
    }
    
    func deleteAll() {
        items.forEach { item in
            mainContext.delete(item)
            saveData()
            fetchItems()
        }
    }
    
    func deleteItems(_ deleteItems: [FoodItem]) {
        withAnimation(Animation.easeInOut(duration: 0.5)) {
            
            deleteItems.forEach { item in
                items.removeAll { listItem in
                    listItem.id == item.id
                }
                mainContext.delete(item)
            }
        }
        saveData()
        fetchItems()
    }
    
    func fetchItems() {
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
    
    func moveItemsToKitchen(_ items: [FoodItem]) {
        items.forEach { item in
            item.owned = true
        }
        saveData()
        fetchItems()
    }
    
    func saveData() {
        do {
            try mainContext.save()
            fetchItems()
        } catch let error {
            print("Error Saving. \(error)")
        }
    }
}
