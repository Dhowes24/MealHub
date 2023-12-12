//
//  TimeSelecter.swift
//  Food@Home
//
//  Created by Derek Howes on 12/6/23.
//

import SwiftUI

struct TimeSelector: View {
    @Binding var timeSelectorObject: timeSelectorObject
    
    var body: some View {
        VStack {
            Group{
                HStack {
                    Text ("\(timeSelectorObject.date.formatted(.dateTime.day().month())), \(timeSelectorObject.date.formatted(.dateTime.weekday()))")
                        .font(.customSystem(size: 16, weight: .semibold))
                        .frame(width: 100)
                    
                    Spacer()
                    
                    HStack {
                        Text(selectedTimes())
                        
                        Spacer()
                        
                        Image(systemName: timeSelectorObject.isDisclosed ? "chevron.up" : "chevron.down")
                            .frame(width: 24, height: 24)
                            .onTapGesture {
                                withAnimation {
                                    timeSelectorObject.isDisclosed.toggle()
                                }
                            }
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 15)
                    .overlay {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .stroke()
                            .frame(width: 200)
                        
                    }
                    .frame(width: 200)
                }
                
                HStack {
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 100, height: 1)
                    
                    VStack() {
                        ForEach(Array(timeSelectorObject.mealTimes.keys), id: \.self) { key in
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
                    .frame(width: 200, height: timeSelectorObject.isDisclosed ? nil : 0, alignment: .top)
                    .clipped()
                }
                
                Spacer()
                
            }
            .padding(.top, 3)
        }
        .padding(.horizontal, 25)
    }
    
    private func binding(for key: String) -> Binding<Bool> {
        return Binding(get: {
            return timeSelectorObject.mealTimes[key] ?? false
        }, set: {
            timeSelectorObject.mealTimes[key] = $0
        })
    }
    
    private func selectedTimes() -> String {
        let trueKeys = timeSelectorObject.mealTimes.filter { $0.value == true }.map { $0.key }
        return (trueKeys.isEmpty ? "Select meal times" : trueKeys.joined(separator: ", "))
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var object = timeSelectorObject( date: Date())
        var body: some View {
            
            TimeSelector(timeSelectorObject: $object)
        }
    }
    return PreviewWrapper()
}


struct timeSelectorObject: Identifiable {
    var id = UUID()
    var isDisclosed: Bool = false
    var mealTimes = ["Breakfast": false, "Lunch": false, "Dinner": false, "Snack": false]
    var date: Date
}
