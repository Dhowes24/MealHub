//
//  RecipeDetailsView.swift
//  Food@Home
//
//  Created by Derek Howes on 10/11/23.
//

import SwiftUI

struct RecipeDetailsView: View {
    var id: Int
    @State private var pullError: Bool = false
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                if let recipeInfo = viewModel.recipeInfo {
                    AsyncImage(
                        url: URL(string: recipeInfo.image),
                        content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 25.0)
                                )
                        },
                        placeholder: {
                            ProgressView()
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
                    
                } else {
                    if pullError {
                        Text("We encountered an error pulling that recipe :(")
                    } else {
                        ProgressView()
                    }
                }
            }
            .onAppear(perform: {
                Task{
                    do {
                        try await viewModel.fetchIndividualRecipe(id: id)
                    }
                    catch {
                        pullError = true
                    }
                }
            })
        }
    }
}

#Preview {
    RecipeDetailsView(id: 1)
}
