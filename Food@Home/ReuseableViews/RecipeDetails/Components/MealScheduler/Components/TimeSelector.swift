//
//  TimeSelecter.swift
//  Food@Home
//
//  Created by Derek Howes on 12/6/23.
//

import SwiftUI

struct TimeSelector: View {
    @Binding var timeSelectorObject: timeSelectorObject
    let mealTimeArray = ["Breakfast", "Lunch", "Snack", "Dinner"]
    let firstSelector: Bool = false
    
    @State var delete: Bool = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        VStack {
            Group{
                HStack {
                    Group {
                        Text ("\(timeSelectorObject.date.formatted(.dateTime.day().month())), \(timeSelectorObject.date.formatted(.dateTime.weekday()))")
                            .font(.customSystem(size: 16, weight: .semibold))
                            .frame(width: 100)
                        
                        Image(systemName: "pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10)
                            .offset(x: -5)
                    }
                        .overlay{
                                DatePicker(
                                    "",
                                    selection: $timeSelectorObject.date,
                                    displayedComponents: [.date]
                                )
                                .blendMode(.destinationOver)
                        }
                    
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
                        ForEach(mealTimeArray, id: \.self) { time in
                            HStack {
                                Toggle(isOn: binding(for: time)) {
                                    Text(time)
                                }
                                .toggleStyle(CheckboxStyle())
                                .disabled(!timeSelectorObject.isDisclosed)
                                
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
        .padding(.horizontal, 10)
        
        Spacer()
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
    
    func areTimesSelected() -> Bool {
        return timeSelectorObject.mealTimes.contains(where: { (_, selected) in
            return selected
        })
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


struct timeSelectorObject: Identifiable, Equatable {
    var id = UUID()
    var isDisclosed: Bool = false
    var mealTimes = ["Breakfast": false, "Lunch": false, "Dinner": false, "Snack": false]
    var date: Date
}
