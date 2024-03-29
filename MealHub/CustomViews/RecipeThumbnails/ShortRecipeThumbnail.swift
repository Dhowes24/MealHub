//
//  RecipeThumbnail.swift
//  MealHub
//
//  Created by Derek Howes on 10/10/23.
//

import SwiftUI

struct ShortRecipeThumbnail: View {
    var recipe: Recipe
    @Binding var path: NavigationPath
    
    
    var body: some View {
        Button(action: {
            path.append(recipe)
        }, label: {
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
                            .background(brandColors.customGrey)
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
        })
        .buttonStyle(.plain)
    }
}


#Preview {
    ShortRecipeThumbnail(
        recipe: Recipe(
            id: 1,
            title: "Healthy Meal Healthy Meal Healthy Meal Healthy Meal",
            image: "https://spoonacular.com/recipeImages/592479-312x231.jpg"),
        path: .constant(NavigationPath())
    )
}
