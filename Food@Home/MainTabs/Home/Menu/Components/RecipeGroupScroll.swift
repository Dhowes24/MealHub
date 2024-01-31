//
//  RecipeGroupScroll.swift
//  Food@Home
//
//  Created by Derek Howes on 12/1/23.
//

import SwiftUI

struct RecipeGroupScroll: View {
    let fetchRecipes: @MainActor (String, String, @escaping ([Recipe]) -> Void) -> Void
    var groupName: String
    @State private var nothingFound: Bool = false
    @Binding var path: NavigationPath
    let queryType: String
    private var randomOffset: String = ""
    @State private var recipeList: [Recipe] = []
    var selectedDate: Date
    
    
    init(fetchRecipes: @MainActor @escaping (String, String, @escaping ([Recipe]) -> Void) -> Void,
         groupName: String,
         path: Binding<NavigationPath>,
         queryType: String,
         selectedDate: Date) {
        
        self.fetchRecipes = fetchRecipes
        self.groupName = groupName
        self._path = path
        self.queryType = queryType
        self.randomOffset = Int.random(in: 1...100).description
        self.selectedDate = selectedDate
    }
    
    var body: some View {
        Group {
            HStack {
                Text(groupName)
                    .font(.customSystem(size: 24, weight: .semibold))
                Spacer()
            }
            .frame(height: 30)
            .padding(.bottom, 24)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 20) {
                    
                    if nothingFound {
                        Text("Sorry! It looks like we could not find any results. \nTry changing up your food preferences above ^")
                        
                    } else {
                        ForEach(recipeList) {recipe in
                            Button(action: {
                                path.append(recipe)
                            }, label: {
                                ShortRecipeThumbnail(recipe: recipe)
                            })
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .padding(.bottom, 30)
        }
        .onAppear {
            if path.count < 2 {
                loadRecipes()
            }
        }
    }
    
    @MainActor private func loadRecipes() {
        fetchRecipes(queryType, randomOffset) { list in
            DispatchQueue.main.async {
                recipeList = list
                nothingFound = recipeList.isEmpty
            }
        }
    }
}

//#Preview {
//    RecipeGroupScroll(groupName: "Breakfast foods", recipeList: <#[Recipe]#>)
//}
