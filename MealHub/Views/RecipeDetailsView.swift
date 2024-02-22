//
//  RecipeDetailsView.swift
//  MealHub
//
//  Created by Derek Howes on 10/11/23.
//

import Combine
import SwiftUI

struct RecipeDetailsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var savedRecipes: FetchedResults<SavedRecipes>
    @StateObject private var viewModel: ViewModel
    
    init(selectedDate: Date = Date(), id: Int, path: Binding<NavigationPath>) {
        self._viewModel = StateObject(wrappedValue: ViewModel(id: id, path: path, selectedDate: selectedDate))
    }
    
    var body: some View {
        VStack {
            HStack {
                subViewHeader(headerText: "", path: viewModel.path, showTabBar: $viewModel.showTabBar)
                
                Spacer()
                
                Image(systemName: viewModel.saved ? "heart.fill" : "heart")
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        if let recipeInfo = viewModel.recipeInfo {
                            PersistenceController.shared.favoriteRecipeToggle(alreadySaved: &viewModel.saved, currentRecipe: recipeInfo, savedRecipes: savedRecipes)
                        } else {
                            //Handle Error
                        }
                    }
                    .padding(.trailing, 16)
            }
            
            SeparatorLine()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                if let recipeInfo = viewModel.recipeInfo {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        AsyncImage(
                            url: URL(string: recipeInfo.image),
                            content: { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 25.0)
                                    )
                            },
                            placeholder: {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 25.0)
                                    )
                            }
                        )
                        .padding(.vertical, 16)
                        
                        Text(recipeInfo.title)
                            .font(.customSystem(size: 24, weight: .bold))
                            .padding(.bottom, 8)
                        
                        VStack (alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "person.2")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24)
                                    .padding(.trailing, 10)
                                
                                Text("Serving: \(recipeInfo.servings.description)")
                                    .font(.customSystem(size: 16, weight: .regular))
                            }
                            
                            HStack {
                                Image(systemName: "clock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24)
                                    .padding(.trailing, 10)
                                
                                Text("Prep Time: \(recipeInfo.readyInMinutes.description) minutes")
                                    .font(.customSystem(size: 16, weight: .regular))
                            }
                        }
                        
                        Text("Ingredients List")
                            .font(.customSystem(size: 16, weight: .semibold))
                            .padding(.vertical, 8)
                        ForEach(recipeInfo.extendedIngredients) {ingredient in
                            
                            HStack(alignment: .top) {
                                Circle()
                                    .frame(width: 6)
                                    .offset(y: 6)
                                    .padding(.horizontal, 8)
                                
                                Text(.init("\(boldedIngredient(ingredient: ingredient))"))
                            }
                        }
                        
                        Text("Detailed Prep Instruction")
                            .font(.customSystem(size: 16, weight: .semibold))
                            .padding(.vertical, 8)
                        ForEach(recipeInfo.analyzedInstructions.indices, id: \.self) {instruction in
                            ForEach(recipeInfo.analyzedInstructions[instruction].steps) { step in
                                HStack(alignment: .top) {
                                    Text("\(step.number.description).")
                                        .padding(.horizontal, 8)
                                    
                                    Text(step.step)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    
                    SeparatorLine()
                    
                    Text("Schedule this meal")
                        .button(color: "black")
                        .onTapGesture {
                            viewModel.showingScheduler.toggle()
                        }
                        .sheet(isPresented: $viewModel.showingScheduler, content: {
                            MealScheduler(path: $viewModel.path, recipe: (Recipe(id: recipeInfo.id, title: recipeInfo.title, image: recipeInfo.image)), selectedDate: viewModel.selectedDate)
                        })
                } else {
                    if viewModel.pullError {
                        Text("We encountered an error pulling that recipe :(")
                    } else {
                        ProgressView()
                    }
                }
                
            }
            .frame(maxWidth: .infinity)
            
            
        }
        .onAppear(perform: {
            Task{
                do {
                    //                        try await viewModel.fetchTestData(id: id)
                    NetworkManager.shared.fetchIndividualRecipe(id: viewModel.id) { recipe, error in
                        DispatchQueue.main.async {
                            if let recipe {
                                viewModel.recipeInfo = recipe
                            } else {
                                //Handle Error
                            }
                        }
                    }
                }
            }
        })
        .onReceive(viewModel.$recipeInfo) { newVal in
            viewModel.saved = savedRecipes.contains(where: { savedRecipe in
                savedRecipe.apiID == Int32(newVal?.id ?? 0)
            })
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(viewModel.showTabBar ? .visible : .hidden, for: .tabBar)
    }
}

#Preview {
    RecipeDetailsView(
        id: 1,
        path: .constant(NavigationPath())
    )
}

private func boldedIngredient(ingredient: ExtendedIngredient) -> String {
    let words = ingredient.name.components(separatedBy: " ")
    
    let boldedText = words.reduce(into: ingredient.original) { result, word in
        if result.contains(word) {
            result = result.replacingOccurrences(of: word, with: "**\(word)**")
        }
    }
    return boldedText
}
