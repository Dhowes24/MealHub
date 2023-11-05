//
//  SearchRecipes.swift
//  Food@Home
//
//  Created by Derek Howes on 10/9/23.
//

import Foundation

func buildSearchRecipes(queryType: String,
                        cuisine: [cuisineType] = [],
                        excludeCuisine: String = "",
                        diet: String = "",
                        includeIngredients: [FoodItem],
                        excludeIngredients: [FoodItem] = [],
                        type: String = "",
                        readyTime: Int = 30) -> String {
    
    let cuisine = (cuisine.isEmpty) ? "" : "cuisine=\(enumToString(itemList: cuisine))&"
    let excludeCuisine = (excludeCuisine.isEmpty) ? "" : "excludeCuisine=\(excludeCuisine)&"
    let diet = createRestrictionsString(listName: "diets")
    let intolerances = createRestrictionsString(listName: "intolerances")
    let includeIngredients = "includeIngredients=\(foodItemsToString(itemList: includeIngredients))&"
    let excludeIngredients = (excludeIngredients.isEmpty) ? "" : "excludeIngredients=kale&"
//    let excludeIngredients = (excludeIngredients.isEmpty) ? "" : "excludeIngredients=\(commaSeparateValues(itemList: excludeIngredients))&"
    let type = (type.isEmpty) ? "" : "type=\(type)&"
    let readyTime = "readyTime=\(readyTime)&"
    
    return "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?query=\(queryType)&\(cuisine)\(excludeCuisine)\(diet)\(intolerances)\(includeIngredients)\(excludeIngredients)\(type)instructionsRequired=true&fillIngredients=false&addRecipeInformation=false&\(readyTime)ignorePantry=true&sort=calories&sortDirection=asc&offset=0&number=2&limitLicense=false&ranking=2"
}

func createRestrictionsString(listName: String) -> String {
    let restrictions = UserDefaults.standard.dictionary(forKey: listName) as? [String: Bool] ?? [:]
    var returnString = ""
    
    for (key, value) in restrictions {
        if value {
            returnString = returnString + (returnString.isEmpty ? "\(listName)=" : "2%C") + key.replacingOccurrences(of: " ", with: "0")
        }
    }
    
    if !returnString.isEmpty {returnString = returnString + "&"}
    return returnString
}

func enumToString(itemList: [Any]) -> String {
    var returnString = ""
    
    for item in itemList {
        if !returnString.isEmpty { returnString += "2%" }
        returnString += "\(String(describing: item))"
    }
    
    return returnString
}

func foodItemsToString(itemList: [FoodItem]) -> String{
    var returnString = ""
    
    for item in itemList {
        if !returnString.isEmpty { returnString += "2%" }
        returnString += "\(item.name ?? "")"
    }
    
    return returnString
}
