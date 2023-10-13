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
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 25.0)
                        )
                },
                placeholder: {
                    ProgressView()
                }
            )
            Text(recipe.title)
                .frame(width: 100, height: 50)
                .clipped()
        }
    }
}

#Preview {
    RecipeThumbnail(recipe: Recipe(
        id: 1,
        title: "Healthy Meal Healthy MealHealthy MealHealthy Meal",
        image: "https://spoonacular.com/recipeImages/592479-312x231.jpg"))
}
