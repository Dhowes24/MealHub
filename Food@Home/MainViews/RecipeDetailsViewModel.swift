//
//  RecipeDetailsViewModel.swift
//  Food@Home
//
//  Created by Derek Howes on 10/11/23.
//

import Foundation

extension RecipeDetailsView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var recipeInfo: RecipeInfo?
        
        let headers = [
            "X-RapidAPI-Key": "33408008c4msh8819a116f83fedep1f022cjsnd3568f4366ce",
            "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
        ]
        
        func fetchIndividualRecipe(id: Int) async throws {            
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
                                print(decodedResponse.extendedIngredients)
                                self.recipeInfo = decodedResponse
                            }
                        }
                    } else {
                        print("Bad decode")
                    }
                }
            })
            dataTask.resume()
        }
    }
}
