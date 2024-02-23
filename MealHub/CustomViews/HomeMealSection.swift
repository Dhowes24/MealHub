//
//  homeMealSection.swift
//  MealHub
//
//  Created by Derek Howes on 12/19/23.
//

import CoreData
import SwiftUI

struct HomeMealSection: View {
    @Binding var editMode: Bool
    var mealTime: String
    var meals: FetchedResults<RecipeCD>
    @Binding var selectedRecipes: [RecipeCD]
    var selectedDate: Date
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(mealTime)
                .font(.customSystem(size: 14, weight: .bold))
            ForEach(meals) { meal in
                if meal.dateAssigned?.formatted(.dateTime.day()) == selectedDate.formatted(.dateTime.day())
                    && meal.mealTime == mealTime{
                    Button(action: {
                        path.append(Recipe(id: Int(meal.apiID), title: meal.name ?? "No Name", image: meal.imageURL ?? ""))
                    }, label: {
                        
                        LongRecipeThumbnail(
                            editMode: $editMode,
                            homeTab: true,
                            meal: meal,
                            path: $path,
                            selectedRecipes: $selectedRecipes
                        )
                        
                    })
                    .buttonStyle(.plain)
                    .padding(.top, 24)
                }
            }
            
            SeparatorLine()
                .padding(.top, 16)
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @FetchRequest(sortDescriptors: []) var meals: FetchedResults<RecipeCD>
        var body: some View {
            HomeMealSection(
                editMode: .constant(false),
                mealTime: "Breakfast",
                meals: meals,
                selectedRecipes: .constant([]),
                selectedDate: Date(),
                path: Binding.constant(NavigationPath())
            )
        }
    }
    return PreviewWrapper()
}
