//
//  FilterSearch.swift
//  MealHub
//
//  Created by Derek Howes on 1/18/24.
//

import SwiftUI
import WaterfallGrid

struct FilterSearch: View {
    @Environment(\.colorScheme) var colorScheme

    @State private var filtersShowing: Bool = false
    @Binding var isKeyboardVisible: Bool
    @Binding var path: NavigationPath
    @Binding var search: String

    var body: some View {
        Group {
            HStack(alignment: .center) {
                HStack {
                    SFSymbols.magnifyingGlass
                        .frame(width: 24, height: 24)
                        .padding(.horizontal, 8)
                    
                    TextField("Looking for something specific?", text: $search)
                        .font(.customSystem(size: 16, weight: .semibold))
                }
                .SearchInputMod()
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                    self.isKeyboardVisible = true
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    self.isKeyboardVisible = false
                }
                
                SFSymbols.chevron.getDirection(direction: filtersShowing ? "down" : "up")
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        withAnimation {
                            filtersShowing.toggle()
                        }
                    }
            }
            .frame(height: 23)
            .padding(.bottom, 24)
            
            VStack() {
                
                FilterSearchOption(title: "Ready In")
                
                FilterSearchOption(title: "Include/Exclude")
                
                FilterSearchOption(title: "Dietary Need")

                FilterSearchOption(title: "Cuisine")

            }
            .frame(height: filtersShowing ? nil : 0, alignment: .top)
            .disabled(!filtersShowing)
            .clipped()
        }
    }
}


#Preview {
    FilterSearch(isKeyboardVisible: .constant(false), path: Binding.constant(NavigationPath()), search: .constant(""))
}
