//
//  ListToggle.swift
//  MealHub
//
//  Created by Derek Howes on 1/9/24.
//

import SwiftUI

struct ListToggle: View {
    @Environment(\.colorScheme) var colorScheme

    var colored: Bool = false
    @Binding var listToggle: Bool
    @Namespace private var animation
    var optionOne: String
    var optionTwo: String
    
    
    var body: some View {
        VStack {
            HStack() {
                ZStack() {
                    Text(optionOne)
                        .fontWeight(listToggle ? .bold : .regular)
                        .foregroundStyle(colored ? .green : colorScheme == .light ? .black: .white)
                    
                    if listToggle {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .foregroundColor(colored ? .green : colorScheme == .light ? .black: .white)
                            .frame(width: 100, height: 2)
                            .offset(y:20)
                            .matchedGeometryEffect(id: "Selector", in: animation)
                    }
                }
                .frame(width: 100, height: 28)
                .padding(.horizontal, 24)
                
                ZStack() {
                    Text(optionTwo)
                        .fontWeight(listToggle ? .regular : .bold)
                        .foregroundStyle(colored ? .red : colorScheme == .light ? .black: .white)

                    
                    if !listToggle {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .foregroundColor(colored ? .red : colorScheme == .light ? .black: .white)
                            .frame(width: 100, height: 2)
                            .offset(y:20)
                            .matchedGeometryEffect(id: "Selector", in: animation)
                    }
                }
                .frame(width: 100, height: 28)
                
                Spacer()
            }
            .onTapGesture {
                withAnimation {
                    listToggle.toggle()
                }
            }
            SeparatorLine()
        }
    }
}


#Preview {
    struct PreviewWrapper: View {
        @State var binding: Bool = true
        var body: some View {
            ListToggle(colored: true, listToggle: $binding, optionOne: "Kitchen", optionTwo: "Grocery List")
        }
    }
    return PreviewWrapper()
}
