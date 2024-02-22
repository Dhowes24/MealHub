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
        if mainContext.hasChanges {
            do {
                try mainContext.save()
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
    
    
    func deleteFoodItems(itemsToDelete: [FoodItem], allFoodItems: inout [FoodItem]) {
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
    
    
    func moveItemsToKitchen(itemsToMove: [FoodItem]) {
        itemsToMove.forEach { item in
            item.owned = true
        }
        saveData()
    }
    
    
    func favoriteRecipeToggle(alreadySaved: inout Bool, currentRecipe: RecipeInfo, savedRecipes: FetchedResults<SavedRecipes>) {
        if alreadySaved {
            if let recipeToDelete =
                savedRecipes.first(where: { savedRecipe in
                    savedRecipe.apiID == Int32(currentRecipe.id)
                }) {
                mainContext.delete(recipeToDelete)
            }
            alreadySaved.toggle()
        } else {
            let savedRecipe = SavedRecipes(context: mainContext)
            savedRecipe.apiID = Int32(currentRecipe.id)
            savedRecipe.dateSaved = Date()
            savedRecipe.imageURL = currentRecipe.image
            savedRecipe.name = currentRecipe.title
            savedRecipe.uuid = UUID()
            
            try? mainContext.save()
            alreadySaved.toggle()
        }
    }
    
}
