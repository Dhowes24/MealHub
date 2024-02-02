//
//  LargeRecipeDisplay.swift
//  Food@Home
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
    
    init(recipeDisplayModel: RecipeDisplayModel, path: Binding<NavigationPath>) {
        _recipeDisplayViewModel = StateObject(wrappedValue: RecipeDisplayViewModel(recipeDisplayModel: recipeDisplayModel))
        self._path = path
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.backward")
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        dismiss()
                    }

                Spacer()
                
                Text(recipeDisplayViewModel.groupName)
                    .font(.customSystem(size: 24, weight: .semibold))
                
                Spacer()
                
                Rectangle()
                    .frame(width: 24, height: 24)
                    .opacity(0.0)
            }
            .padding(.top, 31)
            .padding(.bottom, 13)
                        
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(recipeDisplayViewModel.recipeList, id: \.self) { recipe in
                        Button(action: {
                            path.append(recipe)
                        }, label: {
                            ShortRecipeThumbnail(recipe: recipe)
                        })
                        .buttonStyle(.plain)
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
        }
        .padding(.horizontal, 16)
        .onAppear {
            recipeDisplayViewModel.loadRecipes(returnNumber:16)
        }
        .toolbar(.hidden, for: .navigationBar)

    }
}

//#Preview {
//    LargeRecipeDisplay()
//}
