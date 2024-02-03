//
//  RecipeInfo.swift
//  Food@Home
//
//  Created by Derek Howes on 10/11/23.
//

import Foundation

struct RecipeInfo: Codable, Identifiable {
    var id: Int
    var title: String
    var image: String
    var instructions: String
    let extendedIngredients: [ExtendedIngredient]
    let readyInMinutes, servings: Int

}

// MARK: - ExtendedIngredient
struct ExtendedIngredient: Codable, Identifiable {
    let id: Int
    let aisle, image, name: String
    let amount: Double
    let unit: String
}
