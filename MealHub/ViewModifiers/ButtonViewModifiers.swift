//
//  ButtonViewModifiers.swift
//  MealHub
//
//  Created by Derek Howes on 11/5/23.
//

import Foundation
import SwiftUI

struct BlackButton: ViewModifier {
    var width: CGFloat
    var height: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.customSystem(size: 14, weight: .bold))
            .foregroundStyle(textPink)
            .background(                
                Capsule()
                    .frame(width: width, height: height)
            )
            .frame(width: width, height: height)
    }
}

struct WhiteButton: ViewModifier {
    var width: CGFloat
    var height: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.customSystem(size: 14, weight: .bold))
            .foregroundStyle(.black)
            .frame(width: width, height: height)
            .overlay(
                Capsule()
                    .stroke(.black, lineWidth: 1)
            )
            .background(Capsule().fill(.white))
    }
}

struct GreyButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.customSystem(size: 11, weight: .bold))
            .foregroundStyle(.black)
            .background(Capsule().fill(Color.init(hex: 0xE2E5E9)))
    }
}

extension View {
    func button(color: String, width: CGFloat = 350, height: CGFloat = 60) -> some View {
        switch color {
        case "black" :
            return AnyView(modifier(BlackButton(width: width, height: height)))
        case "white" :
            return AnyView(modifier(WhiteButton(width: width, height: height)))
        case "grey" :
            return AnyView(modifier(GreyButton()))
        default:
            return AnyView(modifier(BlackButton(width: width, height: height)))
        }
    }
}
