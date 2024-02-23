//
//  TextInputModifier.swift
//  MealHub
//
//  Created by Derek Howes on 11/6/23.
//

import Foundation
import SwiftUI

struct TextInputModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        content
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 5.0)
                    .fill(colorScheme == .light ? brandColors.offWhite : .black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(brandColors.customGrey, lineWidth: 1)
                    )
            )
    }
}


extension View {
    func textInputMod() -> some View {
        return(modifier(TextInputModifier()))
    }
}


struct SearchInputModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        content
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 180.0)
                    .fill(colorScheme == .light ? brandColors.offWhite : .black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 180.0)
                            .stroke(brandColors.customGrey, lineWidth: 1)
                    )
            )
    }
}


extension View {
    func SearchInputMod() -> some View {
        return(modifier(SearchInputModifier()))
    }
}
