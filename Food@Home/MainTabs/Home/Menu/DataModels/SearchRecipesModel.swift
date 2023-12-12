//
//  Recipe.swift
//  Food@Home
//
//  Created by Derek Howes on 10/10/23.
//

import Foundation

struct SearchRecipesResults: Codable {
    var results: [Recipe]
}

struct Recipe: Codable, Identifiable, Hashable {
    var id: Int
    var title: String
    var image: String
}
