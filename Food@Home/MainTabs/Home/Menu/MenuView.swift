//
//  MenuView.swift
//  Food@Home
//
//  Created by Derek Howes on 10/5/23.
//

import SwiftUI

struct MenuView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject var tempFoodAccess: FoodItemsAccess
    @Environment(\.dismiss) private var dismiss
    
    var selectedDate: Date
    @State private var showTabBar: Bool  = false
    
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(systemName: "arrow.backward")
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            showTabBar.toggle()
                            dismiss()
                        }
                    
                    Spacer()
                    
                    Image(systemName: "magnifyingglass")
                        .frame(width: 24, height: 24)
                    
                    Image(systemName: "slider.horizontal.3")
                        .frame(width: 24, height: 24)
                }
                .padding(.top, 31)
                .padding(.bottom, 13)
                
                HStack {
                    Text ("\(selectedDate.formatted(.dateTime.day().month())), \(selectedDate.formatted(.dateTime.weekday(.wide)))")
                        .font(.customSystem(size: 16, weight: .semibold))
                    
                    Spacer()
                }
                .frame(height: 23)
                
                HStack {
                    Text ("Pick your meals")
                        .font(.customSystem(size: 32, weight: .semibold))
                    
                    Spacer()
                }
                .frame(height: 35)
                .padding(.bottom, 5)
                
                Spacer()
                
                VStack {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                     RecipeGroupScroll(selectedDate: selectedDate, groupName: "Breakfast Foods", recipeList: viewModel.recipes, path: $path)
                        
                        RecipeGroupScroll(selectedDate: selectedDate, groupName: "Lunch-friendly", recipeList: viewModel.recipes, path: $path)
                    }
                }
            }
            .padding(.horizontal, 17)
            .toolbar(.hidden, for: .navigationBar)
            .toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
        }
        .onAppear {
            Task { try? await viewModel.fetchTestData() }
            //            Task { try? await viewModel.fetchRecipes(queryData: tempFoodAccess) }
        }
    }
}

#Preview {
    MenuView(selectedDate: Date(), path: Binding.constant(NavigationPath()))
}
