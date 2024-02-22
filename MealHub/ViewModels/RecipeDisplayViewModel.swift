//
//  RecipeDisplayViewModel.swift
//  MealHub
//
//  Created by Derek Howes on 2/2/24.
//

import Foundation

@MainActor class RecipeDisplayViewModel: ObservableObject {
    var groupName: String
    @Published var nothingFound: Bool = false
    var queryType: String
    var randomOffset: String
    @Published var recipeList: [Recipe] = []
    var selectedDate: Date

    init(recipeDisplayModel: RecipeDisplayModel) {
        self.groupName = recipeDisplayModel.groupName
        self.queryType = recipeDisplayModel.queryType
        self.randomOffset = Int.random(in: 1...300).description
        self.selectedDate = recipeDisplayModel.selectedDate
    }
    
    func loadRecipes(returnNumber: Int = 6) {
        Task{
            NetworkManager.shared.fetchRecipes(queryType: queryType, offset: randomOffset, returnNumber: 10) { recipes, error in
                if let recipes {
                    DispatchQueue.main.async {
                        self.recipeList = recipes
                        self.nothingFound = recipes.isEmpty
                    }
                } else if let error = error {
                    print("Error occurred: \(error)")
                }
            }
        }
    }
    
    func loadAdditionalRecipes(returnNumber: Int = 6) {
        Task{
            NetworkManager.shared.fetchRecipes(queryType: queryType, offset: Int.random(in: 1...300).description, returnNumber: 10) { recipes, error in
                if let recipes {
                    DispatchQueue.main.async {
                        self.recipeList += recipes
                        self.nothingFound = self.recipeList.isEmpty
                    }
                } else if let error = error {
                    print("Error occurred: \(error)")
                }
            }
        }
    }
}
