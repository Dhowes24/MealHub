//
//  NetworkManager.swift
//  MealHub
//
//  Created by Derek Howes on 2/21/24.
//

import CoreData
import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    
    func fetchRecipes(queryType: String, offset: String, returnNumber: Int, completion: @escaping ([Recipe]?, Error?) -> Void) {
        let queryString = buildSearchRecipes(queryType: queryType, returnNumber: returnNumber, offset: offset)
        
        let request = NSMutableURLRequest(url: NSURL(string: queryString)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print("Error in data task:", error)
                completion(nil, MHError.invalidResponse)
            } else {
                if let decodedResponse = try? JSONDecoder().decode(SearchRecipesResults.self, from: data!) {
                    var returnRecipeList = decodedResponse.results
                    
                    if returnRecipeList.count < returnNumber && offset != "0" {
                        self.fetchRecipes(queryType: queryType, offset: "0", returnNumber: returnNumber, completion: completion)
                    }
                    
                    else if returnRecipeList.count < returnNumber{
                        let returnNumber = (returnNumber - returnRecipeList.count).description

                        self.fetchRandomRecipes(
                            tags: [queryType],
                            returnNumber: returnNumber) { [weak self] list in
                                guard self != nil else { return }
                                
                                DispatchQueue.main.async {
                                    returnRecipeList += list
                                    
                                    completion(returnRecipeList, nil)
                                }
                            }
                    }
                    
                    completion(returnRecipeList, nil)
                } else {
                    print("Error between Data Model and JSON schema")
                    completion(nil, MHError.invalidData)
                }
            }
        })
        dataTask.resume()
    }
    
    
    nonisolated func fetchRandomRecipes(tags:[String], returnNumber: String, completion: @escaping ([Recipe]) -> Void) {
        var tagsArray = tags
        let diet = decodeUserDefaults("Dietary Need").filter { $0.value == true }.keys
        let intolerances = decodeUserDefaults("Intolerances").filter { $0.value == true }.keys
        tagsArray.append(contentsOf: diet)
        tagsArray.append(contentsOf: intolerances)
        
        let queryString = buildGetRandomRecipes(tags: tagsArray, returnNumber: returnNumber)
        
        let request = NSMutableURLRequest(url: NSURL(string: queryString)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print("Error in data task:", error)
                completion([])
            } else {
                if let decodedResponse = try? JSONDecoder().decode(GetRandomRecipes.self, from: data!) {
                    completion(decodedResponse.recipes)
                } else {
                    completion([])
                }
            }
        })
        dataTask.resume()
    }
    
    
    private func buildSearchRecipes(queryType: String,
                                    courseType: String = "main course",
                                    returnNumber: Int,
                                    offset: String) -> String {
        
        var courseType = dictToString(dict: [courseType: true], parameterName: "type")
        if queryType == "breakfast" {
            courseType = dictToString(dict: ["breakfast": true], parameterName: "type")
        }
        
        let queryType = dictToString(dict: [queryType: true], parameterName: "query")
        
        let includeCuisine = dictToString(dict: decodeUserDefaults("Cuisine"), parameterName: "cuisine")
        
        let includeIngredients = pullKitchenIngredients()
        let excludeIngredients = dictToString(dict: decodeUserDefaults("Include/Exclude"), include: false, parameterName: "excludeIngredients")
        
        let dietaryNeed = dictToString(dict: decodeUserDefaults("Dietary Need"), parameterName: "diet")
        
        let maxReadyTime = dictToString(dict: decodeUserDefaults("Ready In"), parameterName: "maxReadyTime")
        
        let intolerances = dictToString(dict: decodeUserDefaults("Intolerances"), parameterName: "intolerances")
        
        let offset = dictToString(dict: [offset: true], parameterName: "offset")
        
        let returnNumber = dictToString(dict: [returnNumber.description: true], parameterName: "number")
        
        let query = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?\(queryType)\(includeCuisine)\(dietaryNeed)\(intolerances)\(includeIngredients)\(excludeIngredients)\(courseType)&instructionsRequired=true&fillIngredients=false&addRecipeInformation=false\(maxReadyTime)&ignorePantry=true&sort=calories&sortDirection=asc\(offset)\(returnNumber)&limitLicense=false&ranking=1"
        
        return query
    }
    
    
    private func buildGetRandomRecipes(tags:[String], returnNumber: String) -> String {
        var tagDict: [String: Bool] = [:]
        tags.forEach { tag in
            tagDict[tag] = true
        }
        
        let tagsDict = dictToString(dict: tagDict, parameterName: "tags")
        let returnNumber = dictToString(dict: [returnNumber.description: true], parameterName: "number")
        
        let query =
        "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/random?\(tagsDict)\(returnNumber)"
        
        return query
    }


    private func dictToString(dict: [String: Bool], include: Bool = true, parameterName: String) -> String {
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
    
    
    private func pullKitchenIngredients() -> String{
        let mainContext: NSManagedObjectContext = PersistenceController.shared.mainContext
        let request = NSFetchRequest<FoodItem>(entityName: "FoodItem")
        
        var returnItems: [String: Bool] = [:]
        var pullItems: [FoodItem] = []
        
        do {
            pullItems = try mainContext.fetch(request)

        } catch let error {
            print("Error fetching. \(error)")
        }
        
        pullItems.forEach { FoodItem in
            if FoodItem.owned {
                returnItems[FoodItem.name ?? "Default"] = true
            }
        }
        
        let fullIngredientList = returnItems.merging(decodeUserDefaults("Include/Exclude")) { (_, new) in new }
        
        return dictToString(dict: fullIngredientList, parameterName: "includeIngredients")
    }


    func fetchIndividualRecipe(id: Int, completion: @escaping (RecipeInfo?, Error?) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/\(id)/information")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                if let decodedResponse = try? JSONDecoder().decode(RecipeInfo.self, from: data!) {
                    Task {
                        await MainActor.run {
                            
                            completion(decodedResponse, nil)
                        }
                    }
                } else {                    
                    print(String(describing: error))
                    completion(nil, MHError.invalidData)
                }
            }
        })
        dataTask.resume()
    }
}
