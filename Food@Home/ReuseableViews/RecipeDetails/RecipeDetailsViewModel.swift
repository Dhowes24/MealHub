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
        
        func fetchTestData(id: Int) async throws {
            do {
                if let filePath = Bundle.main.path(forResource: "SearchRecipeDetailsTestInfo", ofType: "json") {
                    let fileUrl = URL(fileURLWithPath: filePath)
                    let data = try Data(contentsOf: fileUrl)
                    
                    if let decodedResponse = try? JSONDecoder().decode(RecipeInfo.self, from: data) {
                        recipeInfo = decodedResponse
                    }
                    else {
                        print("Error between Data Model and JSON schema")
                    }
                }
            } catch {
                print("error: \(error)")
            }
        }
        
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
                                self.recipeInfo = decodedResponse
                            }
                        }
                    } else {
                        print(String(describing: error))
                    }
                }
            })
            dataTask.resume()
        }
    }
}
