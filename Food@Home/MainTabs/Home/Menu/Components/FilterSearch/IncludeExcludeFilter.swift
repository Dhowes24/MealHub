//
//  IncludeExcludeFilter.swift
//  Food@Home
//
//  Created by Derek Howes on 1/21/24.
//

import SwiftUI

struct IncludeExcludeFilter: View {
    @State var include: Bool = true
    @State var itemString: String = ""
    @Environment(\.dismiss) private var dismiss
    
    @Binding var dict: [String: Bool]
    var decodeUserDefaults: () -> [String: Bool]
    var encodeUserDefaults: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text("Include and Exclude")
                .font(.customSystem(size: 30, weight: .bold))
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            
            
            ListToggle(colored: true, listToggle: $include, optionOne: "Include", optionTwo: "Exclude")
            
            addItemInput(optionOne: "Include",
                         optionTwo: "Exclude",
                         optionOneSelected: include,
                         itemName: $itemString,
                         addItemFunction: addItemToList,
                         disabled: itemString.isEmpty)
        }
        
        let enumeratedItems = Array(dict.sorted(by: { $0.key < $1.key })).enumerated()
        let arrayEnumeratedItems = Array(enumeratedItems)

        ScrollView {
            ForEach(arrayEnumeratedItems, id: \.element.key)  { (index, element) in
                if element.value == include {
                    Text(element.key.description)
                }
            }
        }
        
        
        Spacer()
        
        Text("Done")
            .button(color: "black")
            .onTapGesture {
                withAnimation {
                    dismiss()
                }
            }
        
    }
    
    private func addItemToList(date: Date, itemName: String, include: Bool) {
        print("Do something")
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var bindingDict: [String: Bool] = ["Eggs": false, "Bacon": false, "Dirt": false, "Pizza": true, "Ice Cream": true, "Corn Dogs": true]
        var body: some View {
            
            IncludeExcludeFilter(dict: $bindingDict, decodeUserDefaults: {
                return ["Eggs": false, "Bacon": false, "Dirt": false, "Pizza": true, "Ice Cream": true, "Corn Dogs": true]
            }, encodeUserDefaults: {})

        }
    }
    return PreviewWrapper()
}
