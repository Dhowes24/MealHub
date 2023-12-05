//
//  queryVariableEnums.swift
//  Food@Home
//
//  Created by Derek Howes on 11/5/23.
//

import Foundation

enum cuisineType: String, CaseIterable, CustomStringConvertible, Identifiable {
    case african, chinese, japanese, korean, vietnamese, thai, indian, british, irish, french, italian, mexican, spanish, middleEastern = "middle eastern", jewish, american, cajun, southern, greek, german, nordic, easternEuropean = "eastern european", caribbean, latinAmerican = "latin american"
    
    // Identifiable
    var id: String {
        self.rawValue
    }
    
    // CustomStringConvertible
    var description: String {
        self.rawValue
    }
}

enum mealType: String, CaseIterable, CustomStringConvertible, Identifiable {
    case mainCourse = "main course", sideDish = "side dish", dessert, appetizer, salad, bread, breakfast, soup, beverage, sauce, drink
    
    // Identifiable
    var id: String {
        self.rawValue
    }
    
    // CustomStringConvertible
    var description: String {
        self.rawValue
    }
}

enum intoleranceType: String, CaseIterable, CustomStringConvertible, Identifiable {
    case dairy, egg, gluten, peanut, sesame, seafood, shellfish, soy, sulfite, treeNut = "tree nut", wheat
    
    // Identifiable
    var id: String {
        self.rawValue
    }
    
    // CustomStringConvertible
    var description: String {
        self.rawValue
    }
}

enum dietType: String, CaseIterable, CustomStringConvertible, Identifiable {
    case pescetarian, lactoVegetarian = "lacto vegetarian", ovoVegetarian = "ovo vegetarian", vegan, paleo, primal, vegetarian
    
    // Identifiable
    var id: String {
        self.rawValue
    }
    
    // CustomStringConvertible
    var description: String {
        self.rawValue
    }
}
