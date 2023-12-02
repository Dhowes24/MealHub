//
//  RecipeGroupScroll.swift
//  Food@Home
//
//  Created by Derek Howes on 12/1/23.
//

import SwiftUI

struct RecipeGroupScroll: View {
    var groupName: String
    var recipeList: [Recipe]
    
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
                    ForEach(recipeList) {recipe in
                        NavigationLink(destination: RecipeDetailsView(id: recipe.id)) {
                            RecipeThumbnail(recipe: recipe)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.bottom, 30)
        }
    }
}

//#Preview {
//    RecipeGroupScroll(groupName: "Breakfast foods", recipeList: <#[Recipe]#>)
//}
