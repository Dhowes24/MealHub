//
//  RecipeDetailsViewModel.swift
//  Food@Home
//
//  Created by Derek Howes on 10/11/23.
//

import CoreData
import Foundation
import SwiftUI

extension RecipeDetailsView {
    @MainActor class ViewModel: ObservableObject {
        var id: Int
        @Binding var path: NavigationPath
        @Published var pullError: Bool
        @Published var recipeInfo: RecipeInfo?
        @Published var saved: Bool
        var selectedDate: Date
        @Published var showingScheduler: Bool
        @Published var showTabBar: Bool
        
        init(id: Int,
             path: Binding<NavigationPath>,
             pullError: Bool = false,
             recipeInfo: RecipeInfo? = nil,
             saved: Bool = false,
             selectedDate: Date,
             showingScheduler: Bool = false,
             showTabBar: Bool = false) {
            self.id = id
            self._path = path
            self.pullError = pullError
            self.recipeInfo = recipeInfo
            self.saved = saved
            self.selectedDate = selectedDate
            self.showingScheduler = showingScheduler
            self.showTabBar = showTabBar
        }
        
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
        
        func saveButtonTapped(savedRecipes: FetchedResults<SavedRecipes>, moc: NSManagedObjectContext) {
            if saved {
                if let recipeToDelete =
                    savedRecipes.first(where: { savedRecipe in
                        savedRecipe.apiID == Int32(recipeInfo?.id ?? 0)
                    }) {
                    moc.delete(recipeToDelete)
                }
                saved.toggle()
            } else {
                let savedRecipe = SavedRecipes(context: moc)
                savedRecipe.apiID = Int32(id)
                savedRecipe.dateSaved = Date()
                savedRecipe.imageURL = recipeInfo?.image
                savedRecipe.name = recipeInfo?.title
                savedRecipe.uuid = UUID()
                
                try? moc.save()
                saved.toggle()
            }
        }
    }
}
