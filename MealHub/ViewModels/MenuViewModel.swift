//
//  MenuViewModel.swift
//  MealHub
//
//  Created by Derek Howes on 10/5/23.
//

import Foundation
import SwiftUI

extension MenuView {
    @MainActor class ViewModel: ObservableObject {
        @Binding var path: NavigationPath
        @Published var recipes = [Recipe]()
        @Published var searchCriteria: String = ""
        @Published var searchKeyboardVisible: Bool = false
        var selectedDate: Date
        @Published var showTabBar: Bool  = false
        
        init(path: Binding<NavigationPath>, selectedDate: Date) {
            self._path = path
            self.selectedDate = selectedDate
        }
        
        //Test Data Function
        //------------------------------------------------------------------------------------------
        //        func fetchRecipes(queryType: String, offset: String, returnNumber: Int,  completion: @escaping ([Recipe]) -> Void) {
        //        var tagsArray: [String] = []
        //        tagsArray.append("\(queryType)")
        //        var diet = decodeUserDefaults("Dietary Need").filter { $0.value == true }.keys
        //        diet.forEach { diet in
        //            tagsArray.append("\(diet)")
        //        }
        //        var intolerances = decodeUserDefaults("Intolerances").filter { $0.value == true }.keys
        //        intolerances.forEach { intolerance in
        //            tagsArray.append(intolerance)
        //        }
        //
        //            do {
        //                if let filePath = Bundle.main.path(forResource: "SearchRecipeTestInfo", ofType: "json") {
        //                    let fileUrl = URL(fileURLWithPath: filePath)
        //                    let data = try Data(contentsOf: fileUrl)
        //
        //                    if let decodedResponse = try? JSONDecoder().decode(SearchRecipesResults.self, from: data) {
        //                        completion(decodedResponse.results)
        //                    }
        //                    else {
        //                        print("Error between Data Model and JSON schema")
        //                        completion([])
        //                    }
        //                }
        //            } catch {
        //                print(String(describing: error))
        //            }
        //        }
        
        
    }
}
