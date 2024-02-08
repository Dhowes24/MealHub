//
//  SavedRecipes+CoreDataProperties.swift
//  MealHub
//
//  Created by Derek Howes on 2/5/24.
//
//

import Foundation
import CoreData


extension SavedRecipes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedRecipes> {
        return NSFetchRequest<SavedRecipes>(entityName: "SavedRecipes")
    }

    @NSManaged public var name: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var dateSaved: Date?
    @NSManaged public var apiID: Int32
    @NSManaged public var uuid: UUID?

}
