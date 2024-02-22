//
//  Constants.swift
//  MealHub
//
//  Created by Derek Howes on 6/7/23.
//

import Foundation
import SwiftUI


enum navigationLabels {
    static let homeActive = Label("Home", image: "custom.home.active")
    static let homeInactive = Label("Home", image: "custom.home.inactive")
    static let provisions = Label("Provisions", image: "custom.provisions")
    static let profile = Label("Profile", systemImage: "person.fill")
}


enum SFSymbols {
    static let checkboxFill = Image(systemName: "checkmark.square.fill" )
    static let checkboxEmpty = Image(systemName: "square")
    static let pencil = Image(systemName: "pencil")
    static let magnifyingGlass = Image(systemName: "magnifyingglass")
    static let personTwo = Image(systemName: "person.2")
    static let clock = Image(systemName: "clock")
    static let bell = Image(systemName: "bell")
    
    enum checkmarkSquare {
        static func fill(_ filled: Bool) -> Image {
            return Image(systemName: filled ? "checkmark.square.fill" : "square" )
        }
    }
    
    enum checkmarkCircle {
        static func fill(_ filled: Bool) -> Image {
            return Image(systemName: filled ? "checkmark.circle.fill" : "checkmark.circle" )
        }
    }
    
    enum chevron {
        static func getDirection(direction: String) -> Image {
            return Image(systemName: "chevron.\(direction)")
        }
    }
    
    enum arrow {
        static func getDirection(direction: String) -> Image {
            return Image(systemName: "arrow.\(direction)")
        }
    }
    
    enum heart {
        static func fill(_ filled: Bool) -> Image {
            return Image(systemName: filled ? "heart.fill" : "heart" )
        }
    }
}


enum DeviceTypes {
    enum ScreenSize {
        static let width                = UIScreen.main.bounds.size.width
        static let height               = UIScreen.main.bounds.size.height
        static let maxLength            = max(ScreenSize.width, ScreenSize.height)
        static let minLength            = min(ScreenSize.width, ScreenSize.height)
    }
    
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale

    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale > scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}


enum brandColors {
    static let pink: Color = Color.init(hex: 0xE9BAD5)
    static let purple: Color = Color.init(hex: 0xA078B4)
    static let warm: Color = Color.init(hex: 0xFEF7D7)
    static let orange: Color = Color.init(hex: 0xEFAD5C)
    static let disabledwarm: Color = Color.init(hex: 0xC4C1BC)
    static let green: Color = Color.init(hex: 0x036E5B)

    static let textPink: Color = Color.init(hex: 0xFCDAE2)

    static let offWhite: Color = Color.init(hex: 0xFDFCFC)
    static let lightGrey: Color = Color.init(hex: 0xF6F7F8)
    static let customGrey: Color = Color.init(hex: 0xC6CCD4)
    static let darkGrey: Color = Color.init(hex: 0x919191)
}


//API Calls
let headers = [
    "X-RapidAPI-Key": Bundle.main.infoDictionary?["API_KEY"] as! String,
    "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
]

