//
//  View.swift
//  MealHub
//
//  Created by Derek Howes on 6/6/23.
//

import Foundation
import SwiftUI

extension View {
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CheckboxStyle: ToggleStyle {
    @Environment(\.colorScheme) var colorScheme
    
    
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            configuration.label
            
            Spacer()
            
            SFSymbols.checkmarkSquare.fill(configuration.isOn)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(configuration.isOn ? brandColors.green.scheme(colorScheme) : .gray)
                .font(.system(size: 20, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}
