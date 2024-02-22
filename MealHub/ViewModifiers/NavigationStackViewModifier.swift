//
//  NavigationStackViewModifier.swift
//  MealHub
//
//  Created by Derek Howes on 2/2/24.
//

import Foundation
import SwiftUI

struct HomeNavStackViewMod: ViewModifier {
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
                               meals: meals,
                               path: $path)
            }
            .navigationDestination(for: RecipeDisplayModel.self) { recipeDisplayModel in
                LargeRecipeDisplay(recipeDisplayModel: recipeDisplayModel, path: $path)
            }
    }
}


struct ProfileNavStackViewMod: ViewModifier {
    @Binding var path: NavigationPath

    
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: ArticleInformation.self) { articleInformation in
                GuideTemplate(articleInfo: articleInformation)
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailsView(selectedDate: Date(), id: recipe.id, path: $path)
            }
            .navigationDestination(for: ProfileOptionDetails.self) { details in
                chooseView(viewTitle: details.title)
            }
    }
    
    
    private func chooseView(viewTitle: String) -> some View {
        switch viewTitle {
        case "Food Profile":
            return AnyView(FoodProfileView())
        case "Saved Recipes":
            return AnyView(SavedRecipesView(path: $path))
        case "Resources":
            return AnyView(ResourcesView())
        default:
            return AnyView(FoodProfileView())
        }
    }
}
