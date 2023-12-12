//
//  HomeView.swift
//  Food@Home
//
//  Created by Derek Howes on 11/30/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var path = NavigationPath()
    
    var body: some View {
//        NavigationStack() {
            NavigationStack(path: $path) {
            
            VStack {
                Header(headerText: "Welcome!")
                
                HStack {
                    Text(viewModel.dateLineup[0].formatted(.dateTime.month()))
                        .font(.customSystem(size: 16, weight: .bold))
                    
                    Spacer()
                    
                    Group {
                        Image(systemName: "arrow.backward")
                            .frame(width: 24, height: 24)
                        Text("Previous")
                            .font(.customSystem(size: 14, weight: .bold))
                            .padding(.trailing, 24)
                    }
                    .onTapGesture {
                        viewModel.updateWeekLineup(direction: -1)
                    }
                    
                    Group {
                        Text("Next")
                            .font(.customSystem(size: 14, weight: .bold))
                        Image(systemName: "arrow.forward")
                            .frame(width: 24, height: 24)
                    }
                    .onTapGesture {
                        viewModel.updateWeekLineup(direction: 1)
                    }
                }
                .padding(.horizontal, 17)
                .padding(.bottom, 22)
                
                HStack {
                    ForEach(viewModel.dateLineup, id:  \.self) { day in
                        dateBubble(day: day, selectedDate: viewModel.selectedDate, updatedSelectedDate: viewModel.updateSelectedDate)
                    }
                }
                
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
