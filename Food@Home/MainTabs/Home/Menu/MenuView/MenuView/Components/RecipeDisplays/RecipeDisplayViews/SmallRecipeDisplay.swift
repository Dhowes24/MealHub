//
//  RecipeGroupScroll.swift
//  Food@Home
//
//  Created by Derek Howes on 12/1/23.
//

import SwiftUI

struct SmallRecipeDisplay: View {
    @StateObject var recipeDisplayViewModel: RecipeDisplayViewModel
    @Binding var path: NavigationPath
    let recipeDisplayModel: RecipeDisplayModel
    
    init(recipeDisplayModel: RecipeDisplayModel, path: Binding<NavigationPath>) {
        self.recipeDisplayModel = recipeDisplayModel
        _recipeDisplayViewModel = StateObject(wrappedValue: RecipeDisplayViewModel(recipeDisplayModel: recipeDisplayModel))
        self._path = path
    }
    
    var body: some View {
        Group {
            HStack {
                Text(recipeDisplayViewModel.groupName)
                    .font(.customSystem(size: 24, weight: .semibold))
                Spacer()
                
                
                Button(action: {
                    path.append(recipeDisplayModel)
                }, label: {
                    Image(systemName: "chevron.right")
                        .frame(width: 24, height: 24)
                })
                .buttonStyle(.plain)
                
                
            }
            .frame(height: 30)
            .padding(.bottom, 24)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 20) {
                    
                    if recipeDisplayViewModel.nothingFound {
                        Text("Sorry! It looks like we could not find any results. \nTry changing up your food preferences above ^")
                        
                    } else {
                        ForEach(recipeDisplayViewModel.recipeList) {recipe in
                            ShortRecipeThumbnail(recipe: recipe, path: $path)
                        }
                    }
                }
            }
            .padding(.bottom, 30)
        }
        .onAppear {
            if path.count < 2 {
                recipeDisplayViewModel.loadRecipes()
            }
        }

    }
}

#Preview {
    SmallRecipeDisplay(recipeDisplayModel: RecipeDisplayModel(
        fetchRecipes: { _, _, _, completion in
            let sampleRecipes = [Recipe(id: 1, title: "Sample Recipe", image: "sample.jpg")]
            completion(sampleRecipes)
        },
        groupName: "Lunch-Friendly",
        queryType: "Lunch",
        selectedDate: Date()), path: .constant(NavigationPath()))
}
