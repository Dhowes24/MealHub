//
//  PreferencesFunctions.swift
//  MealHub
//
//  Created by Derek Howes on 1/30/24.
//

import Foundation

public func decodeUserDefaults(_ keyString: String) -> [String: Bool] {
    if let data = UserDefaults.standard.data(forKey: keyString),
       let decodedDictionary = try? PropertyListDecoder().decode([String: Bool].self, from: data) {
        return decodedDictionary
    } else {
        return dictionaryDefaults(keyString)
    }
}

public func dictionaryDefaults(_ keyString: String) -> [String: Bool] {
    switch keyString {
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
    case "Intolerances":
        return [
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
    default:
        return ["15": false, "30": false, "45": false, "60": false, "120": false, "180": true]
    }
}

public func encodeUserDefaults(filterDict: [String: Bool], keyString: String) {
    if let data = try? PropertyListEncoder().encode(filterDict) {
        UserDefaults.standard.set(data, forKey: keyString)
    } else {
        print("no worky")
    }
}
