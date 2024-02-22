//
//  MealScheduler.swift
//  MealHub
//
//  Created by Derek Howes on 12/1/23.
//

import SwiftUI

struct MealScheduler: View {
    @State var dragAmount: CGSize = CGSize.zero
    @Environment(\.dismiss) var dismiss
    @Binding var path: NavigationPath
    var recipe: Recipe
    var selectedDate: Date
    @State private var timeSelectors: [TimeSelectorObject] = []
        
    
    var body: some View {
        GeometryReader { geo in
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
                            ZStack{
                                Group {
                                    TimeSelector(specificDateSelect: specificDatePickerList, timeSelectorObject: selector)
                                    VStack {
                                        TrashLabel(offset: geo.size)
                                            .padding(.top, 10)
                                        Spacer()
                                    }
                                }
                                .modifier(timeSelectorViewModifier(
                                    deleteItem: deleteTimeSelector,
                                    isFirst: timeSelectors.first == selector.wrappedValue
                                    ,selectorReference: selector.wrappedValue)
                                )
                            }
                        }
                        Button("Click to add another meal time") {
                            timeSelectors.append(TimeSelectorObject(date: nextAvaliableDate()))
                        }
                        .disabled(timeSelectors.count > 14)
                        .tint(.blue)
                    }
                }
                .padding(.horizontal, 17)
                
                Spacer()
                
                SeparatorLine()
                
                Button(action: {
                    timeSelectors.forEach { daySelected in
                        daySelected.mealTimes.forEach { (time: String, selected: Bool) in
                            if selected {
                                PersistenceController.shared.setMealTime(recipe: recipe, date: daySelected.date, time: time)
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
                self.timeSelectors.append(TimeSelectorObject(date: selectedDate))
            }
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
    
    
    func deleteTimeSelector(selector: TimeSelectorObject) {
        timeSelectors.removeAll { toRemove in
            toRemove == selector
        }
    }
    
    
    func nextAvaliableDate() -> Date {
        for selectors in 0...timeSelectors.count {
            var dateTaken = false
            let avaliableDate = Date().addingTimeInterval(TimeInterval(86400 * selectors))
            timeSelectors.forEach { TimeSelectorObject in
                if TimeSelectorObject.date.isSameDay(as: avaliableDate) {
                    dateTaken = true
                }
            }
            if !dateTaken {
                return avaliableDate
            }
        }
        return Date()
    }
    
    
    func specificDatePickerList() -> [Date] {
        var currentDate = Date()
        var choosableDates: [Date] = []
        
        while currentDate <= Date().addingTimeInterval(TimeInterval(86400 * 13)) {
            choosableDates.append(currentDate)
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        timeSelectors.forEach { TimeSelectorObject in
            choosableDates.removeAll { Date in
                Date.isSameDay(as: TimeSelectorObject.date)
            }
        }
        
        return choosableDates
    }
}


#Preview {
    MealScheduler(path: Binding.constant(NavigationPath()), recipe: Recipe(id: 1, title: "Recipe Name", image: ""), selectedDate: Date())
}

struct timeSelectorViewModifier: ViewModifier {
    var deleteItem: ((TimeSelectorObject) -> Void)?
    @State var drag: CGSize = CGSize.zero
    var isFirst: Bool
    var selectorReference: TimeSelectorObject
    
    
    func body(content: Content) -> some View {
        if isFirst {
            content
        } else {
            content
                .offset(x: drag.width, y: 0)
                .simultaneousGesture(
                    DragGesture()
                        .onChanged({
                            if $0.translation.width < 0 {
                                drag = abs($0.translation.width) > 55 ?
                                CGSize(width: -55, height: 0) :
                                $0.translation
                            }
                        })
                        .onEnded({ _ in
                            withAnimation(Animation.linear(duration: 0.3)) {
                                if drag.width <= -55 {
                                    if let deleteItem = deleteItem {
                                        deleteItem(selectorReference)
                                    }
                                }
                                drag = .zero
                            }
                        })
                )
        }
    }
}
