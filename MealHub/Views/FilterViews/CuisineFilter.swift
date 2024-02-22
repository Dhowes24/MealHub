//
//  CuisineFilter.swift
//  MealHub
//
//  Created by Derek Howes on 1/24/24.
//

import SwiftUI

struct CuisineFilter: View {
    @Binding var dict: [String: Bool]
    @Environment(\.dismiss) private var dismiss

    
    var body: some View {
        VStack {
            SubViewHeader(headerText: "Select Preferred Cuisine")
            
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
            encodeUserDefaults(filterDict: dict, keyString: "Cuisine")
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    struct PreviewWrapper: View {
        @State var bindingDict: [String: Bool] = [
            "African": false,
            "Chinese": false,
            "Japanese": false,
            "Korean": false,
            "Vietnamese": false,
            "Thai": true,
            "Indian": false,
            "French": false,
            "Italian": false,
            "Mexican": false,
            "Spanish": false,
            "Middle Eastern": false,
            "Jewish": true,
            "American": false,
            "Cajun": false,
            "Southern": false,
            "Greek": false,
            "German": false,
            "Nordic": false,
            "Eastern European": true,
            "Caribbean": false,
            "Latin American": false
        ]
        var body: some View {
            CuisineFilter( dict: $bindingDict)
        }
    }
    return PreviewWrapper()
}
