//
//  SearchRecipes.swift
//  Food@Home
//
//  Created by Derek Howes on 10/9/23.
//

import Foundation

func buildSearchRecipes(queryType: String,
                        courseType: String = "main course",
                        returnNumber: Int = 6,
                        offset: String) -> String {
    
    var courseType = dictToString(dict: [courseType: true], parameterName: "type")
    if queryType == "breakfast" {
        courseType = dictToString(dict: ["breakfast": true], parameterName: "type")
    }
    
    let queryType = dictToString(dict: [queryType: true], parameterName: "query")
    
    let includeCuisine = dictToString(dict: decodeUserDefaults("Cuisine"), parameterName: "cuisine")
    
    let includeIngredients = dictToString(dict: decodeUserDefaults("Include/Exclude"), parameterName: "includeIngredients")
    let excludeIngredients = dictToString(dict: decodeUserDefaults("Include/Exclude"), include: false, parameterName: "excludeIngredients")

    let dietaryNeed = dictToString(dict: decodeUserDefaults("Dietary Need"), parameterName: "diet")
    
    let maxReadyTime = dictToString(dict: decodeUserDefaults("Ready In"), parameterName: "maxReadyTime")
    
    let intolerances = dictToString(dict: decodeUserDefaults("Intolerances"), parameterName: "intolerances")
    
    let offset = dictToString(dict: [offset: true], parameterName: "offset")
    
    let returnNumber = dictToString(dict: [returnNumber.description: true], parameterName: "number")
        
    let query = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?\(queryType)\(includeCuisine)\(dietaryNeed)\(intolerances)\(includeIngredients)\(excludeIngredients)\(courseType)&instructionsRequired=true&fillIngredients=false&addRecipeInformation=false\(maxReadyTime)&ignorePantry=true&sort=calories&sortDirection=asc\(offset)\(returnNumber)&limitLicense=false&ranking=2"
        
    return query
}


func dictToString(dict: [String: Bool], include: Bool = true, parameterName: String) -> String {
    let values = dict.filter { $0.value == include }.map { $0.key }
    var returnString = ""
    var isFirstIteration = true

    values.forEach { value in
        let convertedValue = value.replacingOccurrences(of: " ", with: "%20").lowercased()
        if isFirstIteration {
            if parameterName != "query" {
                returnString.append("&")
            }
            returnString.append("\(parameterName)=\(convertedValue)")
            isFirstIteration = false
        } else {
            returnString.append("%2C\(convertedValue)")
        }
    }
    
    return returnString
}
