//
//  HomeView.swift
//  Food@Home
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
                    .onTapGesture {
                        meals.forEach{ meal in
                            viewModel.deleteScheduledMeal(moc: moc, meal: meal)
                        }
                    }
                
                dateLineup(viewModel: viewModel)
                
                HStack {
                    Spacer()
                    ForEach(viewModel.dateLineup, id:  \.self) { day in
                        dateBubble(day: day, selectedDate: viewModel.selectedDate, updatedSelectedDate: viewModel.updateSelectedDate)
                        
                        Spacer()
                    }
                }
                
                ZStack {
                    ScrollView {
                        VStack {
                            homeMealSection(deleteScheduledMeals: viewModel.deleteScheduledMeal, mealTime: "Breakfast", meals: meals, selectedDate: viewModel.selectedDate, path: $viewModel.path)
                            homeMealSection(deleteScheduledMeals: viewModel.deleteScheduledMeal, mealTime: "Lunch", meals: meals, selectedDate: viewModel.selectedDate, path: $viewModel.path)
                            homeMealSection(deleteScheduledMeals: viewModel.deleteScheduledMeal, mealTime: "Snack", meals: meals, selectedDate: viewModel.selectedDate, path: $viewModel.path)
                            homeMealSection(deleteScheduledMeals: viewModel.deleteScheduledMeal, mealTime: "Dinner", meals: meals, selectedDate: viewModel.selectedDate, path: $viewModel.path)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    VStack {
                        HStack {
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
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 16)
                
                Spacer()
                
                Button(action: {
                    viewModel.path.append(1)
                }, label: {
                    Text(withinDateRange(viewModel.selectedDate) ? "Plan your meal" : "Date unavailable for planning")
                        .button(color: "black")
                        .padding(.bottom, 38)
                })
                .buttonStyle(.plain)
                .disabled(!withinDateRange(viewModel.selectedDate))
                
                SeparatorLine()
            }
            .modifier(HomeNavStackViewMod(meals: meals, path: $viewModel.path, viewModel: viewModel))
        }
    }
}

#Preview {
    HomeView()
}
