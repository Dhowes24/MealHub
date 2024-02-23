//
//  ButtonViewModifiers.swift
//  MealHub
//
//  Created by Derek Howes on 11/5/23.
//

import Foundation
import SwiftUI

enum buttonType {
    case primary, secondary, tertiary
}

struct PrimaryButton: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    var width: CGFloat
    var height: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.customSystem(size: 14, weight: .bold))
            .foregroundStyle(colorScheme == .light ? brandColors.textPink : .black)
            .background(
                Capsule()
                    .frame(width: width, height: height)
            )
            .frame(width: width, height: height)
    }
}


struct SecondaryButton: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    var width: CGFloat
    var height: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.customSystem(size: 14, weight: .bold))
            .foregroundStyle(colorScheme == .light ? .black : .white)
            .frame(width: width, height: height)
            .overlay(
                Capsule()
                    .stroke(colorScheme == .light ? .black : .white, lineWidth: 1)
            )
            .background(Capsule().fill(colorScheme == .light ? .white : .black))
    }
}


struct TertiaryButton: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        content
            .font(.customSystem(size: 11, weight: .bold))
            .foregroundStyle(.black)
            .background(Capsule().fill(Color.init(hex: 0xE2E5E9)))
    }
}


extension View {
    func button(type: buttonType, width: CGFloat = 350, height: CGFloat = 60) -> some View {
        switch type {
        case .primary :
            return AnyView(modifier(PrimaryButton(width: width, height: height)))
        case .secondary :
            return AnyView(modifier(SecondaryButton(width: width, height: height)))
        case .tertiary :
            return AnyView(modifier(TertiaryButton()))
        }
    }
}
