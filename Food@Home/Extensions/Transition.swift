//
//  Transition.swift
//  Food@Home
//
//  Created by Derek Howes on 6/13/23.
//

import Foundation
import SwiftUI

extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))}
}
