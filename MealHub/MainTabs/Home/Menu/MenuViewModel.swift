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
        
        private lazy var downloadSession: URLSession = {
            let configuration = URLSessionConfiguration.default
            return URLSession(configuration: configuration, delegate: nil, delegateQueue: .main)
        }()
        
        //Test Data Function
        //------------------------------------------------------------------------------------------
        func fetchRecipes(queryType: String, offset: String, returnNumber: Int,  completion: @escaping ([Recipe]) -> Void) {
            do {
                if let filePath = Bundle.main.path(forResource: "SearchRecipeTestInfo", ofType: "json") {
                    let fileUrl = URL(fileURLWithPath: filePath)
                    let data = try Data(contentsOf: fileUrl)
                    
                    if let decodedResponse = try? JSONDecoder().decode(SearchRecipesResults.self, from: data) {
                        completion(decodedResponse.results)
                    }
                    else {
                        print("Error between Data Model and JSON schema")
                        completion([])
                    }
                }
            } catch {
                print(String(describing: error))
            }
        }
        
        //Live Data Function
        //------------------------------------------------------------------------------------------
        //        func fetchRecipes(queryType: String, offset: String, returnNumber: Int,  completion: @escaping ([Recipe]) -> Void) {
        //            let queryString = buildSearchRecipes(queryType: queryType, returnNumber: returnNumber, offset: offset)
        //
        //            let request = NSMutableURLRequest(url: NSURL(string: queryString)! as URL,
        //                                              cachePolicy: .useProtocolCachePolicy,
        //                                              timeoutInterval: 10.0)
        //            request.httpMethod = "GET"
        //            request.allHTTPHeaderFields = headers
        //
        //            let session = URLSession.shared
        //            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        //                if let error = error {
        //                    print("Error in data task:", error)
        //                    completion([])
        //                } else {
        //                    if let decodedResponse = try? JSONDecoder().decode(SearchRecipesResults.self, from: data!) {
        //                        completion(decodedResponse.results)
        //                    } else {
        //                        print("Error between Data Model and JSON schema")
        //                        completion([])
        //                    }
        //                }
        //            })
        //            dataTask.resume()
        //        }
    }
}
