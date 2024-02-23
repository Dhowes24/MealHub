//
//  Font.swift
//  MealHub
//
//  Created by Derek Howes on 6/6/23.
//

import Foundation
import SwiftUI

extension Font {
    

    public static var largeTitle: Font {
        return Font.custom("Archivo-Regular", size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
    }
    

    public static var title: Font {
        return Font.custom("Archivo-Regular", size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
    }
    

    public static var headline: Font {
        return Font.custom("Archivo-Regular", size: UIFont.preferredFont(forTextStyle: .headline).pointSize)
    }
    

    public static var subheadline: Font {
        return Font.custom("Archivo-Light", size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize)
    }
    

    public static var body: Font {
        return Font.custom("Archivo-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize)
    }
    

    public static var callout: Font {
        return Font.custom("Archivo-Regular", size: UIFont.preferredFont(forTextStyle: .callout).pointSize)
    }
    

    public static var footnote: Font {
        return Font.custom("Archivo-Regular", size: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
    }
    

    public static var caption: Font {
        return Font.custom("Archivo-Regular", size: UIFont.preferredFont(forTextStyle: .caption1).pointSize)
    }
    
    
    public static func customSystem(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
        var font: String
        switch weight {
        case .bold: font = "Archivo-Bold"
        case .heavy: font = "Archivo-ExtraBold"
        case .light: font = "Archivo-Light"
        case .medium: font = "Archivo-Regular"
        case .semibold: font = "Archivo-SemiBold"
        case .thin: font = "Archivo-Light"
        case .ultraLight: font = "Archivo-Light"
        default: 
            font = "Archivo-Regular"
        }
        return Font.custom(font, size: size)
    }
}
