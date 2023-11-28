//
//  Font.swift
//  Food@Home
//
//  Created by Derek Howes on 6/6/23.
//

import Foundation
import SwiftUI

extension Font {
    
    /// Create a font with the large title text style.
    public static var largeTitle: Font {
        return Font.custom("Archivo-Regular", size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
    }
    
    /// Create a font with the title text style.
    public static var title: Font {
        return Font.custom("Archivo-Regular", size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
    }
    
    /// Create a font with the headline text style.
    public static var headline: Font {
        return Font.custom("Archivo-Regular", size: UIFont.preferredFont(forTextStyle: .headline).pointSize)
    }
    
    /// Create a font with the subheadline text style.
    public static var subheadline: Font {
        return Font.custom("Archivo-Light", size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize)
    }
    
    /// Create a font with the body text style.
    public static var body: Font {
        return Font.custom("Archivo-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize)
    }
    
    /// Create a font with the callout text style.
    public static var callout: Font {
        return Font.custom("Archivo-Regular", size: UIFont.preferredFont(forTextStyle: .callout).pointSize)
    }
    
    /// Create a font with the footnote text style.
    public static var footnote: Font {
        return Font.custom("Archivo-Regular", size: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
    }
    
    /// Create a font with the caption text style.
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
