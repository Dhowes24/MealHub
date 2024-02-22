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
    @Published var myKitchenShowing: Bool  = true
    @Published var newItemName: String = ""
    @Published var items: [FoodItem] = []
    
    init(mainContext: NSManagedObjectContext = PersistenceController.shared.mainContext) {
        self.mainContext = mainContext
        refreshItems()
    }
    
    
    func addItem(dateAdded: Date, name: String, owned: Bool) {
        PersistenceController.shared.addFoodItem(dateAdded: dateAdded, name: name, owned: owned)
        refreshItems()
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
}
