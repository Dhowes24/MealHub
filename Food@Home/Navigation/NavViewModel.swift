//
//  NavViewModel.swift
//  Food@Home
//
//  Created by Derek Howes on 10/22/23.
//

import CoreData
import Foundation

class FoodItemsAccess: ObservableObject {
    
    let mainContext: NSManagedObjectContext

    @Published var cuisineTypes: [cuisineType] = []
    @Published var dietTypes: [dietType] = []
    @Published var foodItems: [FoodItem] = []
    @Published var intoleranceTypes: [intoleranceType] = []
    @Published var mealTypes: [mealType] = []
    @Published var showEditor: Bool = false

    init(mainContext: NSManagedObjectContext = PersistenceController.shared.mainContext) {
        self.mainContext = mainContext
//        fetchFoodItems()
    }
    
//    func addFoodItem(name: String, storage: StorageTypeEnum, nutrition: NutritionTypeEnum) {
//        let item = FoodItem(context: mainContext)
//        item.id = UUID()
//        item.name = name
//        item.storageType = Int16(storage.rawValue)
//        item.nutritionType = Int16(nutrition.rawValue)
//        
//        saveData()
//    }
    
//    func fetchFoodItems() {
//        let request = NSFetchRequest<FoodItem>(entityName: "FoodItem")
//        do {
//            foodItems = try mainContext.fetch(request).sorted(by: {$0.storageType < $1.storageType})
//        } catch let error {
//            print("Error fetching. \(String(describing: error))")
//        }
//    }
    
//    func removeCoreDataInfo() {
//        foodItems.forEach { item in
//            mainContext.delete(item)
//        }
//        saveData()
//    }
//    
//    func saveData() {
//        do {
//            try mainContext.save()
//            fetchFoodItems()
//        } catch let error {
//            print("Error Saving. \(String(describing: error))")
//        }
//    }
    
}
