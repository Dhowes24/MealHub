//
//  Constants.swift
//  Food@Home
//
//  Created by Derek Howes on 6/7/23.
//

import Foundation
import SwiftUI

//Colors
let freezerHead: Color = Color.init(hex: 0xC1E4E4)
let freezerBody: Color = Color.init(hex: 0xD8E7E7)

let fridgeHead: Color = Color.init(hex: 0xCDEAB4)
let fridgeBody: Color = Color.init(hex: 0xDEECD2)

let pantryHead: Color = Color.init(hex: 0xF2EBA6)
let pantryBody: Color = Color.init(hex: 0xF4EECC)


//Storage Types
enum storageType {
    case freezer, fridge, pantry
}
