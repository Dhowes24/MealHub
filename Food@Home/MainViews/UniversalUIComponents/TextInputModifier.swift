//
//  TextInputModifier.swift
//  Food@Home
//
//  Created by Derek Howes on 11/6/23.
//

import Foundation
import SwiftUI

struct TextInputModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 5.0)
                    .fill(offWhite)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(customGrey, lineWidth: 1)
                    )
            )
            .padding(.bottom, 24)
    }
}

extension View {
    func textInputMod() -> some View {
        return(modifier(TextInputModifier()))
    }
}
