//
//  TimeSelecter.swift
//  MealHub
//
//  Created by Derek Howes on 12/6/23.
//

import SwiftUI

struct TimeSelector: View {
    @ObservedObject var viewModel: TimeSelectorViewModel
    
    
    init(specificDateSelect: @escaping () -> [Date], timeSelectorObject: Binding<TimeSelectorObject>) {
        self.viewModel = TimeSelectorViewModel(
            specificDateSelect: specificDateSelect,
            timeSelectorObject: timeSelectorObject
        )
    }
    
    
    var body: some View {
        VStack {
            Group{
                HStack {
                    Group {
                        Text ("\(viewModel.timeSelectorObject.date.formatted(.dateTime.day().month())), \(viewModel.timeSelectorObject.date.formatted(.dateTime.weekday()))")
                            .font(.customSystem(size: 16, weight: .semibold))
                            .frame(width: 100)
                        
                        SFSymbols.pencil
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10)
                            .offset(x: -5)
                    }
                    .overlay{
                        DatePicker(
                            "",
                            selection: $viewModel.timeSelectorObject.date,
                            in: Date()...Date().addingTimeInterval(TimeInterval(86400 * 13)),
                            displayedComponents: [.date]
                        )
                        .blendMode(.destinationOver)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text(viewModel.selectedTimes())
                        
                        Spacer()
                        
                        SFSymbols.chevron.getDirection(direction: viewModel.timeSelectorObject.isDisclosed ? "up" : "down")
                            .frame(width: 24, height: 24)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.timeSelectorObject.isDisclosed.toggle()
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
                        ForEach(viewModel.mealTimeArray, id: \.self) { time in
                            HStack {
                                Toggle(isOn: viewModel.binding(for: time)) {
                                    Text(time)
                                }
                                .toggleStyle(CheckboxStyle())
                                .disabled(!viewModel.timeSelectorObject.isDisclosed)
                                
                                Spacer()
                            }
                            .padding(.leading, 15)
                        }
                    }
                    .frame(width: 200, height: viewModel.timeSelectorObject.isDisclosed ? nil : 0, alignment: .top)
                    .clipped()
                }
                
                Spacer()
                
            }
            .padding(.top, 3)
        }
        .padding(.horizontal, 10)
        
        Spacer()
    }
}


#Preview {
    struct PreviewWrapper: View {
        @State var object = TimeSelectorObject( date: Date())
        var body: some View {
            TimeSelector(specificDateSelect: {[Date()]}, timeSelectorObject: $object)
        }
    }
    return PreviewWrapper()
}


@MainActor class TimeSelectorViewModel: ObservableObject {
    @Published var delete: Bool = false
    @Published private var dragAmount = CGSize.zero
    let firstSelector: Bool = false
    let mealTimeArray = ["Breakfast", "Lunch", "Snack", "Dinner"]
    let specificDateSelect: () -> [Date]
    @Binding var timeSelectorObject: TimeSelectorObject
    
    
    init(specificDateSelect: @escaping () -> [Date], timeSelectorObject: Binding<TimeSelectorObject>) {
        self.specificDateSelect = specificDateSelect
        self._timeSelectorObject = timeSelectorObject
    }
    
    
    func binding(for key: String) -> Binding<Bool> {
        return Binding(get: {
            return self.timeSelectorObject.mealTimes[key] ?? false
        }, set: {
            self.timeSelectorObject.mealTimes[key] = $0
        })
    }
    
    
    func selectedTimes() -> String {
        let trueKeys = timeSelectorObject.mealTimes.filter { $0.value == true }.map { $0.key }
        return (trueKeys.isEmpty ? "Select meal times" : trueKeys.joined(separator: ", "))
    }
    
    
    func areTimesSelected() -> Bool {
        return timeSelectorObject.mealTimes.contains(where: { (_, selected) in
            return selected
        })
    }
}


struct TimeSelectorObject: Identifiable, Equatable {
    var id = UUID()
    var isDisclosed: Bool = false
    var mealTimes = ["Breakfast": false, "Lunch": false, "Dinner": false, "Snack": false]
    var date: Date
}
