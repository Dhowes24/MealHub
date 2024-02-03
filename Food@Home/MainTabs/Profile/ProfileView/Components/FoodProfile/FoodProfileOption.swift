//
//  FoodProfileOption.swift
//  Food@Home
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
        case "Intolerances":
            return AnyView(IntolerancesFilter(dict: $filterDict))
        case "Dietary Need":
            return AnyView(DietaryNeedFilter(dict: $filterDict))
        default:
            return AnyView(IntolerancesFilter(dict: $filterDict))
        }
    }
    
//    private func decodeUserDefaults() -> [String: Bool] {
//        if let data = UserDefaults.standard.data(forKey: title),
//           let decodedDictionary = try? PropertyListDecoder().decode([String: Bool].self, from: data) {
//            return decodedDictionary
//        } else {
//            return dictionaryDefaults()
//        }
//    }
//    
//    private func dictionaryDefaults() -> [String: Bool] {
//        switch title {
//        case "Dietary Need":
//            return [
//                "Pescatarian": false,
//                "Lacto Vegetarian": false,
//                "OVO Vegetarian": false,
//                "Vegan": false,
//                "Paleo": false,
//                "Primal": false,
//                "Vegetarian": false
//            ]
//        case "Intolerances":
//            return [
//                "Dairy": false,
//                "Egg": false,
//                "Gluten": false,
//                "Peanut": false,
//                "Sesame": false,
//                "Seafood": false,
//                "Shellfish": false,
//                "Soy": false,
//                "Sulfite": false,
//                "Tree nut": false,
//                "Wheat": false
//            ]
//        default:
//            return [
//                "Pescatarian": false,
//                "Lacto Vegetarian": false,
//                "OVO Vegetarian": false,
//                "Vegan": false,
//                "Paleo": false,
//                "Primal": false,
//                "Vegetarian": false
//            ]
//        }
//    }
//
//    private func encodeUserDefaults() {
//        if let data = try? PropertyListEncoder().encode(filterDict) {
//            UserDefaults.standard.set(data, forKey: title)
//        } else {
//            print("no worky")
//        }
//    }
    
    private func retrieveSelectedItems() -> String {
        let trueValues = filterDict.filter { $0.value }.map { $0.key }
        let falseValues = filterDict.filter { !$0.value }.map { $0.key }
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
