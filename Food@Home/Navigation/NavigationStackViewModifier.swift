//
//  NavigationStackViewModifier.swift
//  Food@Home
//
//  Created by Derek Howes on 2/2/24.
//

import Foundation
import SwiftUI

struct NavigationDestinationsModifier: ViewModifier {
    var meals: FetchedResults<RecipeCD>
    @Binding var path: NavigationPath
    @StateObject var viewModel: HomeViewModel

    func body(content: Content) -> some View {
        content
            .navigationDestination(for: Int.self) { int in
                MenuView(path: $path, selectedDate: viewModel.selectedDate)
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailsView(selectedDate: viewModel.selectedDate, id: recipe.id, path: $path)
            }
            .navigationDestination(for: Date.self) { date in
                WeekReviewView(date: date,
                               deleteScheduledMeals: viewModel.deleteScheduledMeal,
                               meals: meals,
                               path: $path)
            }
            .navigationDestination(for: RecipeDisplayModel.self) { recipeDisplayModel in
                LargeRecipeDisplay(recipeDisplayModel: recipeDisplayModel, path: $path)
            }
    }
}
