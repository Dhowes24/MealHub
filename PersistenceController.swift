//
//  PersistenceController.swift
//  Food@Home
//
//  Created by Derek Howes on 10/18/23.
//

import Foundation
import CoreData

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
    
    func save() {
        let context = persistentContainer.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(String(describing: error))
            }
        }
    }
}
