//
//  Constants.swift
//  Food@Home
//
//  Created by Derek Howes on 6/7/23.
//

import Foundation
import SwiftUI

//Colors
let brandPink: Color = Color.init(hex: 0xE9BAD5)
let brandPurple: Color = Color.init(hex: 0xA078B4)
let brandWarm: Color = Color.init(hex: 0xFEF7D7)
let brandOrange: Color = Color.init(hex: 0xEFAD5C)

let textPink: Color = Color.init(hex: 0xFCDAE2)

let offWhite: Color = Color.init(hex: 0xFDFCFC)
let customGrey: Color = Color.init(hex: 0xC6CCD4)
let darkGrey: Color = Color.init(hex: 0x657589)

let opacityVal = 0.4


//API Calls
let headers = [
    "X-RapidAPI-Key": Bundle.main.infoDictionary?["API_KEY"] as! String,
    "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
]

//Dimensions
//_______________________________________________________
let capsuleHorizontalPadding: CGFloat = 10
let doubleRowHeight: CGFloat = 82
let rowHeight: CGFloat = 40
let taskNameFontSize: CGFloat = 20
let taskWidthAvailable: CGFloat = UIScreen.screenWidth - 80


//CoreDataDecoding
func nutritionTypeToString(type: Int16) -> String {
    switch type {
    case 1:
        return "Protein"
    case 2:
        return "Starch"
    case 3:
        return "Veg"
    default:
        return "Other"
    }
}

func storageTypeToString(type: Int16) -> String {
    switch type {
    case 1:
        return "Freezer"
    case 2:
        return "Fridge"
    default:
        return "Pantry"
    }
}
