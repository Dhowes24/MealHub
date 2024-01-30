//
//  homeMealSection.swift
//  Food@Home
//
//  Created by Derek Howes on 12/19/23.
//

import CoreData
import SwiftUI

struct homeMealSection: View {
    var deleteScheduledMeals: @MainActor (NSManagedObjectContext, RecipeCD) -> Void
    var mealTime: String
    var meals: FetchedResults<RecipeCD>
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
                        
                        LongRecipeThumbnail(deleteScheduledMeals: deleteScheduledMeals, homeTab: true, meal: meal, path: $path)
                        
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
            homeMealSection(deleteScheduledMeals: {_,_ in }, mealTime: "Breakfast", meals: meals, selectedDate: Date(), path: Binding.constant(NavigationPath()))        }
    }
    return PreviewWrapper()
}
