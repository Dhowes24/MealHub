//
//  LargeRecipeDisplay.swift
//  MealHub
//
//  Created by Derek Howes on 2/2/24.
//

import SwiftUI

struct LargeRecipeDisplay: View {
    let columns = [
        GridItem(.adaptive(minimum: 160))
    ]
    @Environment(\.dismiss) private var dismiss
    @StateObject var recipeDisplayViewModel: RecipeDisplayViewModel
    @Binding var path: NavigationPath
    var specificSearch: Bool
    
    init(recipeDisplayModel: RecipeDisplayModel, path: Binding<NavigationPath>, specificSearch: Bool = false) {
        _recipeDisplayViewModel = StateObject(wrappedValue: RecipeDisplayViewModel(recipeDisplayModel: recipeDisplayModel))
        self._path = path
        self.specificSearch = specificSearch
    }
    
    var body: some View {
        VStack {
            if specificSearch {
                HStack {
                    Text(recipeDisplayViewModel.groupName)
                        .font(.customSystem(size: 24, weight: .semibold))
                    Spacer()
                }
                .frame(height: 30)
                .padding(.bottom, 24)
            } else {
                subViewHeader(headerText: recipeDisplayViewModel.groupName)
            }
                        
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(recipeDisplayViewModel.recipeList, id: \.self) { recipe in
                        ShortRecipeThumbnail(recipe: recipe, path: $path)
                    }
                }
                .padding(.horizontal)
                
                Button {
                    recipeDisplayViewModel.loadAdditionalRecipes()
                } label: {
                    Text("Load Additonal Recipes")
                }
                .padding(16)

            }
            .padding(.horizontal, 16)
        }
        .onAppear {
            recipeDisplayViewModel.loadRecipes(returnNumber:16)
        }
        .toolbar(.hidden, for: .navigationBar)

    }
}

//#Preview {
//    LargeRecipeDisplay()
//}
