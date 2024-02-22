//
//  PersistenceController.swift
//  MealHub
//
//  Created by Derek Howes on 10/18/23.
//

import CoreData
import Foundation
import SwiftUI

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let persistentContainer: NSPersistentContainer
    let backgroundContext: NSManagedObjectContext
    let mainContext: NSManagedObjectContext
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "CoreDataModel")
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSSQLiteStoreType
        
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
        }
        
        mainContext = persistentContainer.viewContext
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        backgroundContext.parent = self.mainContext

    }
    
    func saveData() {
        let context = persistentContainer.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    func addFoodItem(dateAdded: Date, name: String, owned: Bool) {
        let item = FoodItem(context: mainContext)
        item.dateAdded = dateAdded
        item.id = UUID()
        item.name = name
        item.owned = owned
        
        saveData()
    }
    
    
    func deleteAll(items: [FoodItem]) {
        items.forEach { item in
            mainContext.delete(item)
        }
        saveData()
    }
    
    
    func deleteItems(itemsToDelete: [FoodItem], allFoodItems: inout [FoodItem]) {
        withAnimation(Animation.easeInOut(duration: 0.5)) {
            itemsToDelete.forEach { item in
                allFoodItems.removeAll { listItem in
                    listItem.id == item.id
                }
                mainContext.delete(item)
            }
        }
        saveData()
    }
    
    
    func fetchItems(foodItems: inout [FoodItem]) {
        let request = NSFetchRequest<FoodItem>(entityName: "FoodItem")
        
        do {
            let tempItems = try mainContext.fetch(request)
            
            foodItems = tempItems.sorted(by: {
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
    
    
    func moveItemsToKitchen(itemsToMove: [FoodItem]) {
        itemsToMove.forEach { item in
            item.owned = true
        }
        saveData()
    }
    
}
