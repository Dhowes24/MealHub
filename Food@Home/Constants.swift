//
//  Constants.swift
//  Food@Home
//
//  Created by Derek Howes on 6/7/23.
//

import Foundation
import SwiftUI

//Colors
let defaultGray: Color = Color.init(hex: 0xE6E6E6)
let defaultWhite: Color = Color.init(hex: 0xFAFAFA)

let freezerBody: Color = Color.init(hex: 0xD8E7E7)
let freezerHead: Color = Color.init(hex: 0xC1E4E4)
let fridgeBody: Color = Color.init(hex: 0xDEECD2)
let fridgeHead: Color = Color.init(hex: 0xCDEAB4)
let pantryBody: Color = Color.init(hex: 0xF4EECC)
let pantryHead: Color = Color.init(hex: 0xF2EBA6)

let toBuyBody: Color = Color.init(hex: 0xF4EECC)


//API Calls
let headers = [
    "X-RapidAPI-Key": Bundle.main.infoDictionary?["API_KEY"] as! String,
    "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
]
