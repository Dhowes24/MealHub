//
//  ButtonViewModifiers.swift
//  Food@Home
//
//  Created by Derek Howes on 11/5/23.
//

import Foundation
import SwiftUI

struct BlackButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.customSystem(size: 18, weight: .bold))
            .foregroundStyle(textPink)
            .background(                
                Capsule()
                    .frame(width: 350, height: 60)
            )
            .frame(width: 350, height: 60)
    }
}

struct WhiteButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.customSystem(size: 18, weight: .bold))
            .foregroundStyle(.black)
            .frame(width: 350, height: 60)
            .overlay(
                Capsule()
                    .stroke(.black, lineWidth: 1)
            )
            .background(Capsule().fill(.white))
    }
}

extension View {
    func button(color: String) -> some View {
        switch color {
        case "black" :
            return AnyView(modifier(BlackButton()))
        case "white" :
            return AnyView(modifier(WhiteButton()))
        default:
            return AnyView(modifier(BlackButton()))
        }
    }
}
