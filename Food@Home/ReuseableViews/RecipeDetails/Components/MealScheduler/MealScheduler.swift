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
    
    @State private var mealTimes = ["Breakfast": false, "Lunch": false, "Dinner": false, "Snack": false]
    
    @State private var isDisclosed = false
    
    
    private var allKeys: [String] {
        return mealTimes.keys.sorted().map { String($0) }
    }
    
    private func binding(for key: String) -> Binding<Bool> {
        return Binding(get: {
            return self.mealTimes[key] ?? false
        }, set: {
            self.mealTimes[key] = $0
        })
    }
    
    var body: some View {
        
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
            
            
            
            
            
            
            ScrollView(.vertical) {
                Group{
                    HStack {
                        Text ("\(selectedDate.formatted(.dateTime.day().month())), \(selectedDate.formatted(.dateTime.weekday()))")
                            .font(.customSystem(size: 16, weight: .semibold))
                            .frame(width: 100)
                        
                        Spacer()
                        
                        HStack {
                            Text("Select meal times")
                            
                            Image(systemName: isDisclosed ? "chevron.up" : "chevron.down")
                                .frame(width: 24, height: 24)
                                .onTapGesture {
                                    withAnimation {
                                        isDisclosed.toggle()
                                    }
                                }
                        }
                        .padding(6)
                        .overlay {
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .stroke()
                        }
                        .frame(width: 200)
                        
                    }
                    
                    HStack {
                        Rectangle()
                            .fill(.clear)
                            .frame(width: 100, height: 1)
                                                
                        VStack() {
                            ForEach(Array(mealTimes.keys), id: \.self) { key in
                                HStack {
                                    
                                    Toggle(isOn: binding(for: key)) {
                                        Text(key)
                                    }
                                    .toggleStyle(CheckboxStyle())
                                    
                                    Spacer()
                                }
                                .padding(.leading, 15)
                            }
                        }
                        .frame(width: 200, height: isDisclosed ? nil : 0, alignment: .top)
                        .clipped()
                    }
                    
                    Spacer()
                    
                }
                .padding(.top, 5)
            }
            .padding(25)
        }
        .padding(.horizontal, 17)
        
        
        
        
        
        
        
        
        
        Spacer()
        
        SeparatorLine()
        
        Text("Done")
            .button(color: "black")
            .onTapGesture {
                dismiss()
            }
            .padding(.vertical, 8)
    }
    
}

#Preview {
    MealScheduler(selectedDate: Date())
}
