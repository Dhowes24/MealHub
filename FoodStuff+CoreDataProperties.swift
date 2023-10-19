//
//  FoodStuff+CoreDataProperties.swift
//  Food@Home
//
//  Created by Derek Howes on 10/18/23.
//
//

import Foundation
import CoreData


extension FoodStuff {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodStuff> {
        return NSFetchRequest<FoodStuff>(entityName: "FoodStuff")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var nutritionType: Int16
    @NSManaged public var storageType: Int16

}

extension FoodStuff : Identifiable {

}
