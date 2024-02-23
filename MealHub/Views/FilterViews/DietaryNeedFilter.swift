//
//  DietaryNeedFilter.swift
//  MealHub
//
//  Created by Derek Howes on 1/23/24.
//

import SwiftUI

struct DietaryNeedFilter: View {
    @Binding var dict: [String: Bool]
    @Environment(\.dismiss) private var dismiss
    var oldDictVal: [String: Bool]
    
    init(dict: Binding<[String : Bool]>) {
        _dict = dict
        self.oldDictVal = dict.wrappedValue
    }

    
    var body: some View {
        VStack {
            SubViewHeader(headerText: "Select Dietary Needs")
            
            SeparatorLine()
            
            ScrollView(showsIndicators: false) {
                let enumeratedItems = 
                Array(dict.sorted { $0.key < $1.key }).enumerated()
                let arrayEnumeratedItems = Array(enumeratedItems)
                
                ForEach(arrayEnumeratedItems, id: \.element.key)  { (index, element) in
                    if index > 0 {
                        SeparatorLine()
                    }
                    
                    ToggleListItem(controlKey: element.key, displayString: element.key, dict: $dict)
                }
            }
            .padding(.horizontal, 16)
        }
        .onChange(of: dict) { newValue in
            let trueValues = oldDictVal.filter { $0.value }.map { $0.key }
            trueValues.forEach { value in
                dict[value] = false
            }
            encodeUserDefaults(filterDict: dict, keyString: "Dietary Need")
        }
        .navigationBarBackButtonHidden(true)
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
            DietaryNeedFilter(dict: $bindingDict)
        }
    }
    return PreviewWrapper()
}
