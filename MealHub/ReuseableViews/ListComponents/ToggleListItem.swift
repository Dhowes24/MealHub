//
//  ToggleListItem.swift
//  MealHub
//
//  Created by Derek Howes on 1/23/24.
//

import SwiftUI

struct ToggleListItem<Key: Hashable>: View {
    var controlKey: Key
    var displayString: String
    @Binding var dict: [Key: Bool]
    
    var body: some View {
        HStack {
            Text(displayString)
                .font(.customSystem(size: 16, weight: .semibold))
                .padding(.vertical, 16)
            
            Spacer()
            
            Toggle(isOn: binding(for: controlKey, on: $dict)) {
                
            }
            .toggleStyle(CheckboxStyle())
            
        }
        .frame(height: 55)
    }
    
    private func binding<Element>(for key: Element, on dict: Binding<[Element: Bool]>) -> Binding<Bool> {
        return Binding(get: {
            return dict.wrappedValue[key] ?? false
        }, set: { newValue in
            var newDict = dict.wrappedValue
            newDict[key] = newValue
            dict.wrappedValue = newDict
        })
    }
}


#Preview {
    struct PreviewWrapper: View {
        @State var bindingDict: [String: Bool] = [
            "Pescatarian": false,
            "Lacto Vegetarian": false,
            "OVO Vegetarian": false,
            "Vegan": false,
            "Paleo": false,
            "Primal": true,
            "Vegetarian": false
        ]
        var body: some View {
            ToggleListItem(controlKey: "Pescatarian", displayString: "Pescatarian", dict: $bindingDict)

        }
    }
    return PreviewWrapper()
}
