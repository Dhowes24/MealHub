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
                
                ScrollView {
                    VStack {
                        homeMealThumbnail(mealTime: "Breakfast", meals: meals, selectedDate: viewModel.selectedDate, path: $path)
                        homeMealThumbnail(mealTime: "Lunch", meals: meals, selectedDate: viewModel.selectedDate, path: $path)
                        homeMealThumbnail(mealTime: "Snack", meals: meals, selectedDate: viewModel.selectedDate, path: $path)
                        homeMealThumbnail(mealTime: "Dinner", meals: meals, selectedDate: viewModel.selectedDate, path: $path)
                    }
                    .frame(maxWidth: .infinity)
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
            
        }
    }
}

#Preview {
    HomeView()
}
