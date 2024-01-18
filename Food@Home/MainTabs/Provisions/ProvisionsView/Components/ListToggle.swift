//
//  ListToggle.swift
//  Food@Home
//
//  Created by Derek Howes on 1/9/24.
//

import SwiftUI

import SwiftUI

struct ListToggle: View {
    @Binding var listToggle: Bool
    @Namespace private var animation
    
    var body: some View {
        VStack {
            HStack() {
                ZStack() {
                    Text("My Kitchen")
                        .fontWeight(listToggle ? .bold : .regular)
                    
                    if listToggle {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .frame(width: 100, height: 2)
                            .offset(y:20)
                            .matchedGeometryEffect(id: "Selector", in: animation)
                    }
                }
                .frame(width: 100, height: 28)
                .padding(.horizontal, 24)
                
                ZStack() {
                    Text("Grocery List")
                        .fontWeight(listToggle ? .regular : .bold)
                    
                    if !listToggle {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
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
    ListToggle(listToggle: .constant(true))
}
