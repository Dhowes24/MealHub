//
//  IncludeExcludeFilter.swift
//  MealHub
//
//  Created by Derek Howes on 1/21/24.
//

import SwiftUI

struct IncludeExcludeFilter: View {
    @Binding var dict: [String: Bool]
    @Environment(\.dismiss) private var dismiss
    @State var include: Bool = true
    @State var itemString: String = ""
    @State var firstItem: Bool = true
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                subViewHeader(headerText: "Include and Exclude")
                
                ListToggle(colored: true, listToggle: $include, optionOne: "Include", optionTwo: "Exclude")
            }
            
            let enumeratedItems = Array(dict.sorted(by: { $0.key < $1.key })).enumerated()
            let filteredArray = enumeratedItems.filter { $0.element.value == include }
            let arrayEnumeratedItems = Array(filteredArray)
            
            VStack {
                addItemInput(optionOne: "Include",
                             optionTwo: "Exclude",
                             optionOneSelected: include,
                             itemName: $itemString,
                             addItemFunction: addItemToList,
                             disabled: itemString.isEmpty)
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(arrayEnumeratedItems, id: \.element.key)  { (index, element) in
                            
                            if index != arrayEnumeratedItems.first?.offset {
                                SeparatorLine()
                            }
                            
                            HStack {
                                Text(element.key.description)
                                    .font(.customSystem(size: 16, weight: .semibold))
                                
                                Spacer()
                                
                                Image("custom.trash")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 20)
                                    .onTapGesture {
                                        deleteItemFromList(itemName: element.key.description)
                                    }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            
            Spacer()
            
            Text("Done")
                .button(color: "black")
                .onTapGesture {
                    withAnimation {
                        dismiss()
                    }
                }
        }
        .onChange(of: include, perform: { _ in
            firstItem = true
        })
        .navigationBarBackButtonHidden(true)
        
    }
    
    private func addItemToList(date: Date, itemName: String, include: Bool) {
        dict[itemName] = include
        encodeUserDefaults(filterDict: dict, keyString: "Include/Exclude")
    }
    
    private func deleteItemFromList(itemName: String) {
        dict.removeValue(forKey: itemName)
        encodeUserDefaults(filterDict: dict, keyString: "Include/Exclude")
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var bindingDict: [String: Bool] = ["Eggs": false, "Bacon": false, "Dirt": false, "Pizza": true, "Ice Cream": true, "Corn Dogs": true]
        var body: some View {
            IncludeExcludeFilter(dict: $bindingDict)
        }
    }
    return PreviewWrapper()
}

