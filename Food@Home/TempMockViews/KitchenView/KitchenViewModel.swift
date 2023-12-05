//
//  KitchenTestViewModel.swift
//  Food@Home
//
//  Created by Derek Howes on 10/15/23.
//

import CoreData
import Foundation

extension KitchenView {
    @MainActor class ViewModel: ObservableObject {
        
        let mainContext: NSManagedObjectContext

        @Published var foodItems: [FoodItem] = []
        @Published var showEditor: Bool = false
        
        init(mainContext: NSManagedObjectContext = PersistenceController.shared.mainContext) {
            self.mainContext = mainContext
            fetchFoodItems()
        }
        
        func addFoodItem(name: String, storage: StorageTypeEnum, nutrition: NutritionTypeEnum) {
            let item = FoodItem(context: mainContext)
            item.id = UUID()
            item.name = name
            item.storageType = Int16(storage.rawValue)
            item.nutritionType = Int16(nutrition.rawValue)
            
            saveData()
        }
        
        func fetchFoodItems() {
            let request = NSFetchRequest<FoodItem>(entityName: "FoodItem")
            do {
                foodItems = try mainContext.fetch(request).sorted(by: {$0.storageType < $1.storageType})
            } catch let error {
                print("Error fetching. \(String(describing: error))")
            }
        }
        
        func removeCoreDataInfo() {
            foodItems.forEach { item in
                mainContext.delete(item)
            }
            saveData()
        }
        
        func saveData() {
            do {
                try mainContext.save()
                fetchFoodItems()
            } catch let error {
                print("Error Saving. \(String(describing: error))")
            }
        }
    }
}

