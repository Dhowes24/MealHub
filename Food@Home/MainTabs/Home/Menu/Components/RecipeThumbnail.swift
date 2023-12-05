//
//  RecipeThumbnail.swift
//  Food@Home
//
//  Created by Derek Howes on 10/10/23.
//

import SwiftUI

struct RecipeThumbnail: View {
    var recipe: Recipe
    
    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(
                url: URL(string: recipe.image),
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
            Text(recipe.title)
                .font(.customSystem(size: 17, weight: .regular))
                .frame(width: 145, height: 45)
                .clipped()
        }
    }
}

#Preview {
    RecipeThumbnail(recipe: Recipe(
        id: 1,
        title: "Healthy Meal Healthy Meal Healthy Meal Healthy Meal",
        image: "https://spoonacular.com/recipeImages/592479-312x231.jpg"))
}
