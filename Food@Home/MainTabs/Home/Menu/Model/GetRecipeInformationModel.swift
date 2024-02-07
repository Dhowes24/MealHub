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
    let analyzedInstructions: [AnalyzedInstructions]
    let readyInMinutes, servings: Int

}

struct ExtendedIngredient: Codable, Identifiable {
    let id: Int
    let originalName, original, nameClean, name: String
    let amount: Double
    let unit: String
}

struct AnalyzedInstructions: Codable {
    let steps: [Step]
}

struct Step: Codable, Identifiable {
    var id: UUID {
        UUID()
    }
    let number: Int
    let step: String
}

