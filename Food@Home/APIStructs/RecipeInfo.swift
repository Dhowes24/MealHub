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
    var summary: String
    var instructions: String
    let extendedIngredients: [ExtendedIngredient]
    let readyInMinutes, servings: Int

}

// MARK: - ExtendedIngredient
struct ExtendedIngredient: Codable, Identifiable {
    let id: Int
    let aisle, image, consistency, name: String
    let nameClean, original, originalName: String
    let amount: Double
    let unit: String
    let meta: [String]
    let measures: Measures
}

// MARK: - Measures
struct Measures: Codable {
    let us, metric: Metric
}

// MARK: - Metric
struct Metric: Codable {
    let amount: Double
    let unitShort, unitLong: String
}

// MARK: - AnalyzedInstructions
struct AnalyzedInstructions: Codable {
    var steps: [Step]
}

// MARK: - Step
struct Step: Codable {
    var number: Int
    var step: String
    
}
