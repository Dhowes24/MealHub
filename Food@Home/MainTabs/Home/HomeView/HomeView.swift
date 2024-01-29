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
    @State private var path = NavigationPath()
    @FetchRequest(sortDescriptors: []) var meals: FetchedResults<RecipeCD>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationStack(path: $path) {
            
            VStack {
                Header(headerText: "Welcome!")
                    .onTapGesture {
                        meals.forEach{ meal in
                            moc.delete(meal)
                        }
                        try? moc.save()
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
                            homeMealThumbnail(mealTime: "Breakfast", meals: meals, selectedDate: viewModel.selectedDate, path: $path)
                            homeMealThumbnail(mealTime: "Lunch", meals: meals, selectedDate: viewModel.selectedDate, path: $path)
                            homeMealThumbnail(mealTime: "Snack", meals: meals, selectedDate: viewModel.selectedDate, path: $path)
                            homeMealThumbnail(mealTime: "Dinner", meals: meals, selectedDate: viewModel.selectedDate, path: $path)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    VStack {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                path.append(viewModel.selectedDate)
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
                    path.append(1)
                }, label: {
                    Text(withinDateRange(viewModel.selectedDate) ? "Plan your meal" : "Date unavailable for planning")
                        .button(color: "black")
                        .padding(.bottom, 38)
                })
                .buttonStyle(.plain)
                .disabled(!withinDateRange(viewModel.selectedDate))
                
                SeparatorLine()
            }
            .navigationDestination(for: Int.self) { int in
                MenuView(selectedDate: viewModel.selectedDate, path: $path)
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailsView(selectedDate: viewModel.selectedDate,id: recipe.id, path: $path)
            }
            .navigationDestination(for: Date.self) { date in
                WeekReviewView(date: date, meals: meals, path: $path)
            }
        }
    }
}

#Preview {
    HomeView()
}
