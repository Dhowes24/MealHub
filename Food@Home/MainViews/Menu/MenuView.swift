//
//  MenuView.swift
//  Food@Home
//
//  Created by Derek Howes on 10/5/23.
//

import SwiftUI

struct MenuView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 20) {
                        ForEach(viewModel.recipes) {recipe in
                            NavigationLink(destination: RecipeDetailsView(id: recipe.id)) {
                                RecipeThumbnail(recipe: recipe)
                            }
                        }
                    }
                }
            }
            .onAppear {
                Task { try? await viewModel.fetchTestData() }
//                    Task { try? await viewModel.fetchRecipes() }
            }
        }
    }
}

#Preview {
    MenuView()
}
