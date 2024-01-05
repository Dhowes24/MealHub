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
                    ForEach(viewModel.dateLineup, id:  \.self) { day in
                        dateBubble(day: day, selectedDate: viewModel.selectedDate, updatedSelectedDate: viewModel.updateSelectedDate)
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
                                    .font(.customSystem(size: 11, weight: .bold))
                                    .foregroundStyle(.black)
                                    .frame(width: 100, height: 25)
                                .background(Capsule().fill(Color.init(hex: 0xE2E5E9)))
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
                    Text("Plan your meal")
                        .button(color: "black")
                        .padding(.bottom, 38)
                })
                .buttonStyle(.plain)
                
                SeparatorLine()
            }
            .navigationDestination(for: Int.self) { int in
                MenuView(selectedDate: viewModel.selectedDate, path: $path)
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailsView(id: recipe.id, path: $path)
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
