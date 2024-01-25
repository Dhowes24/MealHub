//
//  DietaryNeedFilter.swift
//  Food@Home
//
//  Created by Derek Howes on 1/23/24.
//

import SwiftUI

struct DietaryNeedFilter: View {
    
    var decodeUserDefaults: () -> [String: Bool]
    @Binding var dict: [String: Bool]
    @Environment(\.dismiss) private var dismiss
    var encodeUserDefaults: () -> Void
    var oldDictVal: [String: Bool]
    
    init(dict: Binding<[String : Bool]>,
         decodeUserDefaults: @escaping () -> [String : Bool],
         encodeUserDefaults: @escaping () -> Void) {
        self.decodeUserDefaults = decodeUserDefaults
        _dict = dict
        self.encodeUserDefaults = encodeUserDefaults
        self.oldDictVal = dict.wrappedValue
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
                
                Text ("Select Dietary Needs")
                    .font(.customSystem(size: 18, weight: .bold))
                
                Spacer()
                
                Rectangle()
                    .frame(width: 24, height: 24)
                    .opacity(0.0)
            }
            .padding(.top, 31)
            .padding(.bottom, 13)
            .padding(.horizontal, 16)
            
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
            encodeUserDefaults()
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
            DietaryNeedFilter(dict: $bindingDict, decodeUserDefaults: {
                return [
                    "Pescatarian": false,
                    "Lacto Vegetarian": false,
                    "OVO Vegetarian": false,
                    "Vegan": false,
                    "Paleo": false,
                    "Primal": true,
                    "Vegetarian": false
                ]
            }, encodeUserDefaults: {})
        }
    }
    return PreviewWrapper()
}
