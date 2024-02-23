//
//  HomeView.swift
//  MealHub
//
//  Created by Derek Howes on 11/30/23.
//

import CoreData
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @FetchRequest(sortDescriptors: []) var meals: FetchedResults<RecipeCD>
    
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            
            VStack {
                Header(headerText: "Welcome!")
                
                DateLineup(viewModel: viewModel)
                
                HStack {
                    Spacer()
                    ForEach(viewModel.dateLineup, id:  \.self) { day in
                        DateBubble(day: day, selectedDate: viewModel.selectedDate, updatedSelectedDate: viewModel.updateSelectedDate)
                        
                        Spacer()
                    }
                }
                
                VStack {
                    HStack {
                        Button(action: {
                            withAnimation {
                                viewModel.editMode.toggle()
                            }
                        }, label: {
                            Text(viewModel.editMode ? "Cancel" : "Edit")
                                .frame(width: 50, height: 25)
                                .button(type: .tertiary)
                        })
                        .buttonStyle(.plain)
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.path.append(viewModel.selectedDate)
                        }, label: {
                            Text("See week view")
                                .frame(width: 100, height: 25)
                                .button(type: .tertiary)
                        })
                        .buttonStyle(.plain)
                    }
                    .padding(.vertical, 16)
                    
                    ScrollView {
                        VStack {
                            HomeMealSection(
                                editMode: $viewModel.editMode,
                                mealTime: "Breakfast",
                                meals: meals,
                                selectedRecipes: $viewModel.selectedRecipes,
                                selectedDate: viewModel.selectedDate,
                                path: $viewModel.path)
                            HomeMealSection(
                                editMode: $viewModel.editMode,
                                mealTime: "Lunch",
                                meals: meals,
                                selectedRecipes: $viewModel.selectedRecipes,
                                selectedDate: viewModel.selectedDate,
                                path: $viewModel.path)
                            HomeMealSection(
                                editMode: $viewModel.editMode,
                                mealTime: "Snack",
                                meals: meals,
                                selectedRecipes: $viewModel.selectedRecipes,
                                selectedDate: viewModel.selectedDate,
                                path: $viewModel.path)
                            HomeMealSection(
                                editMode: $viewModel.editMode,
                                mealTime: "Dinner",
                                meals: meals,
                                selectedRecipes: $viewModel.selectedRecipes,
                                selectedDate: viewModel.selectedDate,
                                path: $viewModel.path)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                Button(action: {
                    if viewModel.editMode {
                        PersistenceController.shared.deleteSelectedHomeViewMeals(selectedMeals: &viewModel.selectedRecipes)
                        viewModel.editMode = false
                    } else {
                        viewModel.path.append(1)
                    }
                }, label: {
                    Text(viewModel.editMode ? "Delete selected items" : viewModel.selectedDate.withinTwoWeeks() ?  "Plan your meal" : "Date unavailable for planning")
                        .button(type: .primary)
                        .padding(.bottom, 38)
                })
                .buttonStyle(.plain)
                .disabled(viewModel.editMode ?
                          viewModel.selectedRecipes.isEmpty
                          : !viewModel.selectedDate.withinTwoWeeks())
                
                SeparatorLine()
            }
            .modifier(HomeNavStackViewMod(meals: meals, path: $viewModel.path, viewModel: viewModel))
        }
        .onChange(of: viewModel.selectedDate) { _ in
            viewModel.selectedRecipes.removeAll()
            viewModel.editMode = false
        }
    }
}


#Preview {
    HomeView()
}
