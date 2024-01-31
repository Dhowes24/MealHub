//
//  IntolerancesFilter.swift
//  Food@Home
//
//  Created by Derek Howes on 1/27/24.
//

import SwiftUI

struct IntolerancesFilter: View {
    @Binding var dict: [String: Bool]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.backward")
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        dismiss()
                    }
                
                Spacer()
                
                Text ("Select Food Intolerances")
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
        .onChange(of: dict) { _ in
            encodeUserDefaults(filterDict: dict, keyString: "Intolerances")
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var bindingDict: [String: Bool] = [
            "Dairy": false,
            "Egg": false,
            "Gluten": false,
            "Peanut": false,
            "Sesame": false,
            "Seafood": false,
            "Shellfish": false,
            "Soy": false,
            "Sulfite": false,
            "Tree nut": false,
            "Wheat": false
        ]
        var body: some View {
            IntolerancesFilter(dict: $bindingDict)
        }
    }
    return PreviewWrapper()
}
