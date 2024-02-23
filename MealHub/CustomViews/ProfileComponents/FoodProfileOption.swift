//
//  FoodProfileOption.swift
//  MealHub
//
//  Created by Derek Howes on 1/27/24.
//

import SwiftUI

struct FoodProfileOption: View {
    @State private var filterDict: [String: Bool] = [:]
    var title: String
        
    init(title: String) {
        self.title = title
        _filterDict = State(initialValue: decodeUserDefaults(title))
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                let subtext = retrieveSelectedItems()
                Text(title)
                    .font(.customSystem(size: 16, weight: .semibold))
                    .frame(height: 24)
                    .offset(y: subtext.isEmpty ? 14: 0 )
                
                    Text(subtext)
                        .font(.customSystem(size: 13, weight: .regular))
                        .foregroundStyle(brandColors.darkGrey)
                        .frame(width: 290, height: 16, alignment: .leading)
            }
            
            Spacer()
            
            NavigationLink(destination: chooseView()) {
                Text("Edit")
                    .frame(width: 45, height: 24)
                    .button(type: .tertiary)
            }
            .buttonStyle(.plain)
        }
        .frame(height: 55)
        
        SeparatorLine()
    }
    
    
    private func chooseView() -> some View {
        switch title {
        case "Intolerances":
            return AnyView(IntolerancesFilter(dict: $filterDict))
        case "Dietary Need":
            return AnyView(DietaryNeedFilter(dict: $filterDict))
        default:
            return AnyView(IntolerancesFilter(dict: $filterDict))
        }
    }
    
    
    private func retrieveSelectedItems() -> String {
        let trueValues = filterDict.filter { $0.value }.map { $0.key }
        var returnString: String = ""
        switch title {
        case "Dietary Need":
            for (index, element) in trueValues.enumerated() {
                if index == 0 {
                    returnString += "\(element)"
                } else {
                    returnString += ", \(element)"
                }
            }
            return returnString
        case "Intolerances":
            for (index, element) in trueValues.enumerated() {
                if index == 0 {
                    returnString += "\(element)"
                } else {
                    returnString += ", \(element)"
                }
            }
            return returnString
        default:
            return ""
        }
    }
}

#Preview {
    FoodProfileOption(title: "Intolerances")
}
