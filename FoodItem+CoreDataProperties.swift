//
//  FoodItem+CoreDataProperties.swift
//  Food@Home
//
//  Created by Derek Howes on 10/18/23.
//
//

import Foundation
import CoreData


extension FoodItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodItem> {
        return NSFetchRequest<FoodItem>(entityName: "FoodItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var nutritionType: Int16
    @NSManaged public var storageType: Int16

}

extension FoodItem : Identifiable {

}
