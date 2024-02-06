//
//  RecipeDetailsView.swift
//  Food@Home
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
        self._viewModel = StateObject(wrappedValue: ViewModel(selectedDate: selectedDate, id: id, path: path))
    }
        
    var body: some View {
        VStack {
            HStack {
                subViewHeader(headerText: "")
                
                Spacer()
                
                Image(systemName: viewModel.saved ? "heart.fill" : "heart")
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        viewModel.saveButtonTapped(savedRecipes: savedRecipes, moc: moc)
                    }
                    .padding(.trailing, 16)
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                if let recipeInfo = viewModel.recipeInfo {
                    AsyncImage(
                        url: URL(string: recipeInfo.image),
                        content: { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 145, height: 145)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 25.0)
                                )
                        },
                        placeholder: {
                            ProgressView()
                                .frame(width: 145, height: 145)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 25.0)
                                )
                        }
                    )
                    
                    Text(recipeInfo.title)
                    
                    ForEach(recipeInfo.extendedIngredients) {ingredient in
                        HStack(alignment: .firstTextBaseline,spacing: 5){
                            Text(ingredient.name)
                                .frame(width: 100, alignment: .leading)
                            Text("\(Int(ingredient.amount)) \(ingredient.unit)")
                                .frame(width: 100, alignment: .leading)
                        }
                        .font(.custom("small", size: 8))
                        .padding(.horizontal, 30)
                        .frame(width: 300, alignment: .center)
                        
                    }
                    
                    HStack {
                        Text("Ready in \(recipeInfo.readyInMinutes) Minutes")
                            .frame(width: 150, alignment: .trailing)
                        
                        Text("|")
                        
                        Text("Servings \(recipeInfo.servings)")
                            .frame(width: 150, alignment: .leading)
                    }
                    
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
            .toolbar(.hidden, for: .navigationBar)
            .onAppear(perform: {
                Task{
                    do {
//                        try await viewModel.fetchTestData(id: id)
                        try await viewModel.fetchIndividualRecipe(id: viewModel.id)
                    }
                    catch {
                        viewModel.pullError = true
                    }
                }
            })
            .onReceive(viewModel.$recipeInfo) { newVal in
                viewModel.saved = savedRecipes.contains(where: { savedRecipe in
                    savedRecipe.apiID == Int32(newVal?.id ?? 0)
                })
            }
            
        }
    }
}

//#Preview {
////    RecipeDetailsView(id: 1)
//    RecipeDetailsView(id: 1,
//                      path: Binding.constant([]))
//}
