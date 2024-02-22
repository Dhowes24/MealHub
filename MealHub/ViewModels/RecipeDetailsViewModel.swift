//
//  RecipeDetailsViewModel.swift
//  MealHub
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
        
        //Test Data Function
        //------------------------------------------------------------------------------------------
        //        func fetchIndividualRecipe(id: Int) async throws {
        //            do {
        //                if let filePath = Bundle.main.path(forResource: "RecipeDetailsTestInfo", ofType: "json") {
        //                    let fileUrl = URL(fileURLWithPath: filePath)
        //                    let data = try Data(contentsOf: fileUrl)
        //
        //                    if let decodedResponse = try? JSONDecoder().decode(RecipeInfo.self, from: data) {
        //                        recipeInfo = decodedResponse
        //                    }
        //                    else {
        //                        print("Error between Data Model and JSON schema")
        //                    }
        //                }
        //            } catch {
        //                print("error: \(error)")
        //            }
        //        }
    }
}
