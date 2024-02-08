//
//  SearchRecipeModel.swift
//  MealHub
//
//  Created by Derek Howes on 10/10/23.
//

import Foundation

struct SearchRecipesResults: Codable {
    var results: [Recipe]
}

struct GetRandomRecipes: Codable {
    var recipes: [Recipe]
}

struct Recipe: Codable, Identifiable, Hashable {
    var id: Int
    var title: String
    var image: String
}
