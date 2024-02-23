//
//  MenuView.swift
//  MealHub
//
//  Created by Derek Howes on 10/5/23.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: ViewModel
    
    init(path: Binding<NavigationPath>, selectedDate: Date ) {
        self._viewModel = StateObject(wrappedValue: ViewModel(path: path, selectedDate: selectedDate))
    }
    
    
    var body: some View {
        VStack {
            HStack {
                SubViewHeader(headerText: "", path: viewModel.path, showTabBar: $viewModel.showTabBar)

                Text ("\(viewModel.selectedDate.formatted(.dateTime.weekday())), \(viewModel.selectedDate.formatted(.dateTime.day().month()))")
                    .font(.customSystem(size: 16, weight: .bold))
                    .padding(.trailing, 16)
            }
            VStack {
                FilterSearch(isKeyboardVisible: $viewModel.searchKeyboardVisible, path: $viewModel.path, search: $viewModel.searchCriteria)
                
                HStack {
                    Text ("Pick your meal")
                        .font(.customSystem(size: 32, weight: .semibold))
                    
                    Spacer()
                }
                .frame(height: 35)
                .padding(.bottom, 5)
                
                Spacer()
                
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        if !viewModel.searchCriteria.isEmpty && !viewModel.searchKeyboardVisible {
                            LargeRecipeDisplay(
                                recipeDisplayModel: RecipeDisplayModel(
                                    groupName: "Search For: \(viewModel.searchCriteria)",
                                    queryType: "\(viewModel.searchCriteria)",
                                    selectedDate: viewModel.selectedDate),
                                path: $viewModel.path,
                                specificSearch: true)
                        } else {
                            SmallRecipeDisplay(recipeDisplayModel: RecipeDisplayModel(
                                groupName: "Breakfast Foods",
                                queryType: "breakfast",
                                selectedDate: viewModel.selectedDate),
                                               path: $viewModel.path)

                            SmallRecipeDisplay(recipeDisplayModel: RecipeDisplayModel(
                                groupName: "Lunch-friendly",
                                queryType: "lunch",
                                selectedDate: viewModel.selectedDate),
                                               path: $viewModel.path)

                            SmallRecipeDisplay(recipeDisplayModel: RecipeDisplayModel(
                                groupName: "Dinner Meals",
                                queryType: "dinner",
                                selectedDate: viewModel.selectedDate),
                                               path: $viewModel.path)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .toolbar(.hidden, for: .navigationBar)
            .toolbar(viewModel.showTabBar ? .visible : .hidden, for: .tabBar)
        }
    }
}


#Preview {
    MenuView(path: Binding.constant(NavigationPath()), selectedDate: Date())
}
