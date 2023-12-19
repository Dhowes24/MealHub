//
//  RecipeDetailsView.swift
//  Food@Home
//
//  Created by Derek Howes on 10/11/23.
//
import SwiftUI

struct RecipeDetailsView: View {
    var selectedDate: Date = Date()
    var id: Int
    @State private var pullError: Bool = false
    @StateObject private var viewModel = ViewModel()
    @State private var showingScheduler: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    @Binding var path: NavigationPath
        
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.backward")
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        dismiss()
                    }
                Spacer()
            }
            .padding(.top, 31)
            .padding(.bottom, 13)
            
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
                            showingScheduler.toggle()
                        }
                        .sheet(isPresented: $showingScheduler, content: {
                            MealScheduler(selectedDate: selectedDate, recipe: (Recipe(id: recipeInfo.id, title: recipeInfo.title, image: recipeInfo.image)) ,path: $path)
                        })
                } else {
                    if pullError {
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
                        try await viewModel.fetchTestData(id: id)
                        //                        try await viewModel.fetchIndividualRecipe(id: id)
                    }
                    catch {
                        pullError = true
                    }
                }
            })
        }
    }
}

//#Preview {
////    RecipeDetailsView(id: 1)
//    RecipeDetailsView(id: 1,
//                      path: Binding.constant([]))
//}
