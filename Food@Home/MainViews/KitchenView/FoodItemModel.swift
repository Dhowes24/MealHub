//
//  FoodItem.swift
//  Food@Home
//
//  Created by Derek Howes on 10/15/23.
//

import Foundation

enum StorageTypeEnum: Int, Codable, CaseIterable {
    case freezer = 1
    case fridge = 2
    case pantry = 3
}

enum NutritionTypeEnum: Int, Codable, CaseIterable {
    case protein = 1
    case starch = 2
    case veg = 3
    case other = 4
}
