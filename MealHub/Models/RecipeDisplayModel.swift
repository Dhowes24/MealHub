//
//  RecipeDisplayModel.swift
//  MealHub
//
//  Created by Derek Howes on 2/2/24.
//

import Foundation

struct RecipeDisplayModel: Identifiable, Hashable {
    var id = UUID()
    var groupName: String
    var queryType: String
    var selectedDate: Date
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    static func == (lhs: RecipeDisplayModel, rhs: RecipeDisplayModel) -> Bool {
        return lhs.id == rhs.id
    }
}
