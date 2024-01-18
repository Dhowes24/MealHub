//
//  FoodItem+CoreDataProperties.swift
//  Food@Home
//
//  Created by Derek Howes on 1/10/24.
//
//

import Foundation
import CoreData


extension FoodItem: Comparable {
    public static func < (lhs: FoodItem, rhs: FoodItem) -> Bool {
        return lhs.dateAdded ?? Date() < rhs.dateAdded ?? Date()
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodItem> {
        return NSFetchRequest<FoodItem>(entityName: "FoodItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var dateAdded: Date?
    @NSManaged public var owned: Bool

}
