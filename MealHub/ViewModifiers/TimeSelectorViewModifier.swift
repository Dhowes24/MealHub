//
//  TimeSelectorViewModifier.swift
//  MealHub
//
//  Created by Derek Howes on 6/7/24.
//

import Foundation
import SwiftUI

struct TimeSelectorViewModifier: ViewModifier {
    var deleteItem: ((TimeSelectorObject) -> Void)?
    @State var drag: CGSize = CGSize.zero
    var isFirst: Bool
    var selectorReference: TimeSelectorObject
    
    
    func body(content: Content) -> some View {
        if isFirst {
            content
        } else {
            content
                .offset(x: drag.width, y: 0)
                .simultaneousGesture(
                    DragGesture()
                        .onChanged({
                            if $0.translation.width < 0 {
                                drag = abs($0.translation.width) > 55 ?
                                CGSize(width: -55, height: 0) :
                                $0.translation
                            }
                        })
                        .onEnded({ _ in
                            withAnimation(Animation.linear(duration: 0.3)) {
                                if drag.width <= -55 {
                                    if let deleteItem = deleteItem {
                                        deleteItem(selectorReference)
                                    }
                                }
                                drag = .zero
                            }
                        })
                )
        }
    }
}
