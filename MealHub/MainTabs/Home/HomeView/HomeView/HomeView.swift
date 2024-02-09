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
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            
            VStack {
                Header(headerText: "Welcome!")
                
                dateLineup(viewModel: viewModel)
                
                HStack {
                    Spacer()
                    ForEach(viewModel.dateLineup, id:  \.self) { day in
                        dateBubble(day: day, selectedDate: viewModel.selectedDate, updatedSelectedDate: viewModel.updateSelectedDate)
                        
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
                                .button(color: "grey")
                        })
                        .buttonStyle(.plain)
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.path.append(viewModel.selectedDate)
                        }, label: {
                            Text("See week view")
                                .frame(width: 100, height: 25)
                                .button(color: "grey")
                        })
                        .buttonStyle(.plain)
                    }
                    .padding(.vertical, 16)
                    
                    ScrollView {
                        
                        VStack {
                            homeMealSection(
                                editMode: $viewModel.editMode,
                                mealTime: "Breakfast",
                                meals: meals,
                                selectedRecipes: $viewModel.selectedRecipes,
                                selectedDate: viewModel.selectedDate,
                                path: $viewModel.path)
                            homeMealSection(
                                editMode: $viewModel.editMode,
                                mealTime: "Lunch",
                                meals: meals,
                                selectedRecipes: $viewModel.selectedRecipes,
                                selectedDate: viewModel.selectedDate,
                                path: $viewModel.path)
                            homeMealSection(
                                editMode: $viewModel.editMode,
                                mealTime: "Snack",
                                meals: meals,
                                selectedRecipes: $viewModel.selectedRecipes,
                                selectedDate: viewModel.selectedDate,
                                path: $viewModel.path)
                            homeMealSection(
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
                        viewModel.deleteScheduledMeal(moc: moc)
                    } else {
                        viewModel.path.append(1)
                    }
                }, label: {
                    Text(viewModel.editMode ? "Delete selected items" : withinDateRange(viewModel.selectedDate) ?  "Plan your meal" : "Date unavailable for planning")
                        .button(color: "black")
                        .padding(.bottom, 38)
                })
                .buttonStyle(.plain)
                .disabled(viewModel.editMode ?
                          viewModel.selectedRecipes.isEmpty
                          : !withinDateRange(viewModel.selectedDate))
                
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
