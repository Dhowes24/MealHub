//
//  WeekReviewView.swift
//  MealHub
//
//  Created by Derek Howes on 1/5/24.
//

import CoreData
import SwiftUI

struct WeekReviewView: View {
    var date: Date
    @Environment(\.dismiss) private var dismiss
    var meals: FetchedResults<RecipeCD>
    let mealTimeArray = ["Breakfast", "Lunch", "Snack", "Dinner"]
    @State private var showTabBar: Bool  = false
    @Binding var path: NavigationPath
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                SFSymbols.arrow.getDirection(direction: "backward")
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        showTabBar.toggle()
                        dismiss()
                    }
                
                Spacer()
            }
            .padding(.top, 30)
            .padding(.bottom, 13)
            
            Text("\(date.formatted(.dateTime.day().month())) - " +
                 (date.isSameMonth(as: Calendar.current.date(byAdding: .day, value: 6, to: date)!) ?
                 "\(Calendar.current.date(byAdding: .day, value: 6, to: date)!.formatted(.dateTime.day()))" :
                    "\(Calendar.current.date(byAdding: .day, value: 6, to: date)!.formatted(.dateTime.day().month()))"))
            .font(.customSystem(size: 16, weight: .semibold))
            .padding(.bottom, 5)
            
            Text("Week view")
                .font(.customSystem(size: 32, weight: .semibold))
                .padding(.bottom, 35)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(0..<7, id: \.self) { index in
                        if let dateRow = Calendar.current.date(byAdding: .day, value: index, to: date) {
                            
                            HStack {
                                Text("\(dateRow.formatted(.dateTime.weekday())), \(dateRow.formatted(.dateTime.day().month()))")
                                    .foregroundStyle(brandColors.darkGrey)
                                    .font(.customSystem(size: 12, weight: .semibold))
                                    .frame(width: 75, height: 15, alignment: .leading)
                                    .padding(.top, 8)
                                    .padding(.bottom, 16)
                                
                                Spacer()
                            }
                            
                            ForEach(mealTimeArray, id: \.self) { mealTime in
                                ForEach(meals) { meal in
                                    if meal.mealTime ?? "nil" == mealTime && 
                                        (meal.dateAssigned ?? Date()).isSameDay(as: dateRow) {
                                        LongRecipeThumbnail(
                                            editMode: .constant(false),
                                            meal: meal,
                                            path: $path,
                                            selectedRecipes: .constant([])
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
        
        Button(action: {
            showTabBar.toggle()
            dismiss()
        }, label: {
            Text("Back")
                .button(type: .secondary)
                .padding(.bottom, 38)
        })
        .buttonStyle(.plain)
    }
}


#Preview {
    struct PreviewWrapper: View {
        @FetchRequest(sortDescriptors: []) var meals: FetchedResults<RecipeCD>
        var body: some View {
            WeekReviewView(
                date: Calendar.current.date(byAdding: .day, value: 0, to: Date())!,
                meals: meals,
                path: Binding.constant(NavigationPath())
            )
        }
    }
    return PreviewWrapper()
}
