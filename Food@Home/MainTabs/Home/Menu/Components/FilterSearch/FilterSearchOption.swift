//
//  FilterSearchOption.swift
//  Food@Home
//
//  Created by Derek Howes on 1/21/24.
//

import SwiftUI

struct FilterSearchOption: View {
    
    @State private var filterDict: [String: Bool] = [:]
    var title: String
        
    init(title: String) {
        
        self.title = title
        _filterDict = State(initialValue: decodeUserDefaults())
        
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
            return AnyView(ReadyInFilter(decodeUserDefaults: decodeUserDefaults, dict: $filterDict, encodeUserDefaults: encodeUserDefaults))
        case "Include/Exclude":
            return AnyView(IncludeExcludeFilter(decodeUserDefaults: decodeUserDefaults, dict: $filterDict, encodeUserDefaults: encodeUserDefaults))
        case "Dietary Need":
            return AnyView(DietaryNeedFilter(dict: $filterDict, decodeUserDefaults: decodeUserDefaults, encodeUserDefaults: encodeUserDefaults))
        case "Cuisine":
            return AnyView(CuisineFilter(decodeUserDefaults: decodeUserDefaults, dict: $filterDict, encodeUserDefaults: encodeUserDefaults))
        default:
            return AnyView(ReadyInFilter(decodeUserDefaults: decodeUserDefaults, dict: $filterDict, encodeUserDefaults: encodeUserDefaults))
        }
    }
    
    private func decodeUserDefaults() -> [String: Bool] {
        if let data = UserDefaults.standard.data(forKey: title),
           let decodedDictionary = try? PropertyListDecoder().decode([String: Bool].self, from: data) {
            return decodedDictionary
        } else {
            return dictionaryDefaults()
        }
    }
    
    private func dictionaryDefaults() -> [String: Bool] {
        switch title {
        case "Ready In":
            return [
                "15": false,
                "30": false,
                "45": false,
                "60": false,
                "120": false,
                "180": true]
        case "Include/Exclude":
            return [:]
        case "Dietary Need":
            return [
                "Pescatarian": false,
                "Lacto Vegetarian": false,
                "OVO Vegetarian": false,
                "Vegan": false,
                "Paleo": false,
                "Primal": false,
                "Vegetarian": false
            ]
        case "Cuisine":
            return [
                "African": false,
                "Chinese": false,
                "Japanese": false,
                "Korean": false,
                "Vietnamese": false,
                "Thai": false,
                "Indian": false,
                "French": false,
                "Italian": false,
                "Mexican": false,
                "Spanish": false,
                "Middle Eastern": false,
                "Jewish": false,
                "American": false,
                "Cajun": false,
                "Southern": false,
                "Greek": false,
                "German": false,
                "Nordic": false,
                "Eastern European": false,
                "Caribbean": false,
                "Latin American": false
            ]
        default:
            return ["15": false, "30": false, "45": false, "60": false, "120": false, "180": true]
        }
    }

    private func encodeUserDefaults() {
        if let data = try? PropertyListEncoder().encode(filterDict) {
            UserDefaults.standard.set(data, forKey: title)
        } else {
            print("no worky")
        }
    }
    
    private func retrieveSelectedItems() -> String {
        let trueValues = filterDict.filter { $0.value }.map { $0.key }
        let falseValues = filterDict.filter { !$0.value }.map { $0.key }
        var returnString: String = ""
        switch title {
        case "Ready In":
            var minuteCount = trueValues.first ?? "180"
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