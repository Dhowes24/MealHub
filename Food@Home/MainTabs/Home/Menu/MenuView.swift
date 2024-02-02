//
//  MenuView.swift
//  Food@Home
//
//  Created by Derek Howes on 10/5/23.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var path: NavigationPath
    var selectedDate: Date
    @State private var showTabBar: Bool  = false
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(systemName: "arrow.backward")
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            showTabBar = true
                            dismiss()
                        }
                    
                    Spacer()
                    
                    Text ("\(selectedDate.formatted(.dateTime.weekday())), \(selectedDate.formatted(.dateTime.day().month()))")
                        .font(.customSystem(size: 16, weight: .bold))
                }
                .padding(.top, 31)
                .padding(.bottom, 13)
                
                FilterSearch(path: $path)
                
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
                        
                        SmallRecipeDisplay(recipeDisplayModel: RecipeDisplayModel(
                            fetchRecipes: viewModel.fetchRecipes,
                            groupName: "Breakfast Foods",
                            queryType: "breakfast",
                            selectedDate: selectedDate),
                                          path: $path)
                        
                        SmallRecipeDisplay(recipeDisplayModel: RecipeDisplayModel(
                            fetchRecipes: viewModel.fetchRecipes,
                            groupName: "Lunch-friendly",
                            queryType: "lunch",
                            selectedDate: selectedDate),
                                          path: $path)
                        
                        SmallRecipeDisplay(recipeDisplayModel: RecipeDisplayModel(
                            fetchRecipes: viewModel.fetchRecipes,
                            groupName: "Dinner Meals",
                            queryType: "dinner",
                            selectedDate: selectedDate), 
                                          path: $path)
                    }
                }
            }
            .padding(.horizontal, 17)
            .toolbar(.hidden, for: .navigationBar)
            .toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
        }
    }
}

#Preview {
    MenuView(path: Binding.constant(NavigationPath()), selectedDate: Date())
}
