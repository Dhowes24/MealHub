//
//  SelectorView.swift
//  Food@Home
//
//  Created by Derek Howes on 10/24/23.
//

import SwiftUI
import Foundation

struct SelectorView: View {
    @State private var itemSelection: [String: Bool]
    let listName: String
    let singleSelect: Bool
    
    init(listName: String) {
        self.listName = listName
        self.singleSelect = listName == "diets"
        
        if let savedItemSelection = UserDefaults.standard.dictionary(forKey: listName) as? [String: Bool] {
            self.itemSelection = savedItemSelection
        } else {
            var defaults = [String:Bool]()
            switch listName {
            case "diets":
                for type in dietType.allCases {
                    defaults[type.description] = false
                }
            case "intolerances":
                for type in intoleranceType.allCases {
                    defaults[type.description] = false
                }
            default:
                defaults = [:]
            }
            self.itemSelection = defaults
            UserDefaults.standard.set(self.itemSelection, forKey: listName)
        }
    }
    
    var body: some View {
        
        ScrollView(.vertical) {
            ForEach(itemSelection.sorted(by: { $0.key < $1.key }), id:\.key) { key, value in
                optionSelectView(itemSelection: $itemSelection, optionDescription: key, singleSelect: singleSelect)
            }
        }.onChange(of: itemSelection) { _ in
            UserDefaults.standard.set(itemSelection, forKey: listName)
        }.onAppear {
            itemSelection = UserDefaults.standard.dictionary(forKey: listName) as? [String: Bool] ?? 
            ["We've encountered an error": true]
        }
    }
}

struct optionSelectView: View {
    @Binding var itemSelection: [String:Bool]
    var optionDescription: String
    let singleSelect: Bool
    
    var body: some View {
        HStack {
            Image(systemName: itemSelection[optionDescription] ?? false ? "checkmark.square.fill" : "square")
                .onTapGesture {
                    if singleSelect { itemSelection.keys.forEach { itemSelection[$0] = false }}
                    itemSelection[optionDescription]?.toggle()
                }
            Spacer()
            Text(optionDescription)
        }
        .frame(width: 200, height: 40)
        .padding(.horizontal, 20)
    }
}

#Preview {
    SelectorView(
        listName: "diets"
    )
}
