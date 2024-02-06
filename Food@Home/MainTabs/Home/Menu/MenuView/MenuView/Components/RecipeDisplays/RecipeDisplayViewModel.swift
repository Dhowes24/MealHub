//
//  RecipeDisplayViewModel.swift
//  Food@Home
//
//  Created by Derek Howes on 2/2/24.
//

import Foundation

@MainActor class RecipeDisplayViewModel: ObservableObject {
    var fetchRecipes: @MainActor (String, String, Int, @escaping ([Recipe]) -> Void) -> Void
    var groupName: String
    @Published var nothingFound: Bool = false
    var queryType: String
    var randomOffset: String
    @Published var recipeList: [Recipe] = []
    var selectedDate: Date

    init(recipeDisplayModel: RecipeDisplayModel) {
        self.fetchRecipes = recipeDisplayModel.fetchRecipes
        self.groupName = recipeDisplayModel.groupName
        self.queryType = recipeDisplayModel.queryType
        self.randomOffset = Int.random(in: 1...300).description
        self.selectedDate = recipeDisplayModel.selectedDate
    }
    
    func loadRecipes(returnNumber: Int = 6) {
        fetchRecipes(queryType, randomOffset, returnNumber) { list in
            DispatchQueue.main.async { [self] in
                self.recipeList = list
                self.nothingFound = self.recipeList.isEmpty
            }
        }
    }
    
    func loadAdditionalRecipes(returnNumber: Int = 6) {
        fetchRecipes(queryType, Int.random(in: 1...300).description, returnNumber) { list in
            DispatchQueue.main.async { [self] in
                self.recipeList += list
                self.nothingFound = self.recipeList.isEmpty
            }
        }
    }
}
