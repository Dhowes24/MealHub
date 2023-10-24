//
//  SearchRecipes.swift
//  Food@Home
//
//  Created by Derek Howes on 10/9/23.
//

import Foundation

func buildSearchRecipes(queryType: String,
                        cuisine: String = "",
                        excludeCuisine: String = "",
                        diet: String = "",
                        intolerances: String = "",
                        includeIngredients: [FoodItem],
                        excludeIngredients: [FoodItem] = [],
                        type: String = "",
                        readyTime: Int = 30) -> String {
    
    let cuisine = (cuisine.isEmpty) ? "" : "cuisine=\(cuisine)&"
    let excludeCuisine = (excludeCuisine.isEmpty) ? "" : "excludeCuisine=\(excludeCuisine)&"
    let diet = (diet.isEmpty) ? "" : "diet=\(diet)&"
    let intolerances = (intolerances.isEmpty) ? "" : "intolerances=\(intolerances)&"
    let includeIngredients = "includeIngredients=\(commaSeparateValues(itemList: includeIngredients))&"
    let excludeIngredients = (excludeIngredients.isEmpty) ? "" : "excludeIngredients=kale&"
//    let excludeIngredients = (excludeIngredients.isEmpty) ? "" : "excludeIngredients=\(commaSeparateValues(itemList: excludeIngredients))&"
    let type = (type.isEmpty) ? "" : "type=\(type)&"
    let readyTime = "readyTime=\(readyTime)&"
    
    return "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?query=\(queryType)&\(cuisine)\(excludeCuisine)\(diet)\(intolerances)\(includeIngredients)\(excludeIngredients)\(type)instructionsRequired=true&fillIngredients=false&addRecipeInformation=false&\(readyTime)ignorePantry=true&sort=calories&sortDirection=asc&offset=0&number=2&limitLicense=false&ranking=2"
    
//    return "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?query=pizza&includeIngredients=tomato&type=dessert&instructionsRequired=true&fillIngredients=false&addRecipeInformation=false&maxReadyTime=20&ignorePantry=true&sort=calories&sortDirection=asc&offset=0&number=2&limitLicense=false&ranking=2"
}

func commaSeparateValues(itemList: [FoodItem]) -> String{
    var returnString = ""
    
    for item in itemList {
        if !returnString.isEmpty { returnString += "2%" }
        returnString += "\(item.name ?? "")"
    }
    
    return returnString
}

//Possible Cuisine Types: african, chinese, japanese, korean, vietnamese, thai, indian, british, irish, french, italian, mexican, spanish, middle eastern, jewish, american, cajun, southern, greek, german, nordic, eastern european, caribbean, latin american

//Possible Types: main course, side dish, dessert, appetizer, salad, bread, breakfast, soup, beverage, sauce, drink

//Possible Intolerances: dairy, egg, gluten, peanut, sesame, seafood, shellfish, soy, sulfite, tree nut, wheat.

//Possible diets: pescetarian, lacto vegetarian, ovo vegetarian, vegan, paleo, primal, vegetarian
