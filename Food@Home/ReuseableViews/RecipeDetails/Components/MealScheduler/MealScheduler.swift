//
//  MealScheduler.swift
//  Food@Home
//
//  Created by Derek Howes on 12/1/23.
//

import SwiftUI

struct MealScheduler: View {
    @Environment(\.dismiss) var dismiss
    var selectedDate: Date
    @State private var timeSelectors: [timeSelectorObject] = []
    var recipe: Recipe
    
    @Binding var path: NavigationPath
    @Environment(\.managedObjectContext) var moc

    
    var body: some View {
        
        VStack{
            VStack {
                HStack {
                    Image(systemName: "arrow.backward")
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            dismiss()
                        }
                    Spacer()
                    
                    Text("Schedule Meal")
                        .font(.customSystem(size: 18, weight: .heavy))
                        .frame(width: 245, height: 24)
                    
                    Spacer()
                    
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 24, height: 24)
                }
                .padding(.top, 31)
                .padding(.bottom, 13)
                
            }
            .padding(.horizontal, 17)
            
            SeparatorLine()
            
            VStack {
                Text("Select the meal times you'd like to schedule your meal for.")
                    .font(.customSystem(size: 16, weight: .regular))
                    .padding(.vertical, 24)
                
                SeparatorLine()
                    .padding(.bottom, 25)
                
                ScrollView(.vertical) {
                    ForEach($timeSelectors) { selector in
                        TimeSelector(timeSelectorObject: selector)
                    }
                    
                    Button("Click to add another meal time") {                        
                        timeSelectors.append(timeSelectorObject(date: selectedDate))
                    }
                }
                
            }
            .padding(.horizontal, 17)
                        
            Spacer()
            
            SeparatorLine()
            
            Button(action: {
                
                timeSelectors.forEach { daySelected in
                    daySelected.mealTimes.forEach { (time: String, selected: Bool) in
                        if selected {
                            let recipeCD = RecipeCD(context: moc)
                            recipeCD.apiID = Int32(recipe.id)
                            recipeCD.dateAssigned = daySelected.date
                            recipeCD.imageURL = recipe.image
                            recipeCD.mealTime = time
                            recipeCD.name = recipe.title
                            
                            try? moc.save()
                        }
                    }
                }

                path = NavigationPath()
            }, label: {
                Text("Done")
                    .button(color: "black")
            })
            .buttonStyle(.plain)
            .disabled(noTimesSelected())
            
        }
        .onAppear {
            self.timeSelectors.append(timeSelectorObject(date: selectedDate))
        }
    }
    
    func noTimesSelected() -> Bool {
        var returnValue = false
        timeSelectors.forEach { timeSelectorObject in
            if !timeSelectorObject.mealTimes.values.contains(true) {
                returnValue = true
            }
        }
        return returnValue
    }
}

#Preview {
    MealScheduler(selectedDate: Date(), recipe: Recipe(id: 1, title: "Recipe Name", image: ""), path: Binding.constant(NavigationPath()))

}
