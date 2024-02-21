//
//  FilterSearchOption.swift
//  MealHub
//
//  Created by Derek Howes on 1/21/24.
//

import SwiftUI

struct FilterSearchOption: View {
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
                        .foregroundStyle(darkGrey)
                        .frame(width: 290, height: 16, alignment: .leading)
            }
            
            Spacer()
            
            NavigationLink(destination: chooseView()) {
                Text("Edit")
                    .frame(width: 45, height: 24)
                    .button(color: "grey")
            }
            .buttonStyle(.plain)
        }
        .frame(height: 55)
        
        SeparatorLine()
    }
        
    private func chooseView() -> some View {
        switch title {
        case "Ready In":
            return AnyView(ReadyInFilter(dict: $filterDict))
        case "Include/Exclude":
            return AnyView(IncludeExcludeFilter(dict: $filterDict))
        case "Dietary Need":
            return AnyView(DietaryNeedFilter(dict: $filterDict))
        case "Cuisine":
            return AnyView(CuisineFilter(dict: $filterDict))
        default:
            return AnyView(ReadyInFilter(dict: $filterDict))
        }
    }
    
    private func retrieveSelectedItems() -> String {
        let trueValues = filterDict.filter { $0.value }.map { $0.key }
        let falseValues = filterDict.filter { !$0.value }.map { $0.key }
        var returnString: String = ""
        switch title {
        case "Ready In":
            let minuteCount = trueValues.first ?? "180"
            return "\(minuteCount) minutes"
        case "Include/Exclude":
            for (index, element) in trueValues.enumerated() {
                if index == 0 {
                    returnString += "Include: \(element)"
                } else {
                    returnString += ", \(element)"
                }
            }
            for (index, element) in falseValues.enumerated() {
                if index == 0 {
                    if !trueValues.isEmpty { returnString += " | " }
                    returnString += "Exclude: \(element)"
                } else {
                    returnString += ", \(element)"
                }
            }
            return returnString
        case "Dietary Need":
            for (index, element) in trueValues.enumerated() {
                if index == 0 {
                    returnString += "\(element)"
                } else {
                    returnString += ", \(element)"
                }
            }
            return returnString
        case "Cuisine":
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
    struct PreviewWrapper: View {
        var body: some View {
            FilterSearchOption(title: "Ready In")
        }
    }
    return PreviewWrapper()
}
