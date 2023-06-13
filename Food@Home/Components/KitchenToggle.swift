//
//  KitchenToggle.swift
//  Food@Home
//
//  Created by Derek Howes on 6/7/23.
//

import SwiftUI

struct KitchenToggle: View {
    @Binding var isAtHome: Bool
    @Namespace private var animation
    
    var body: some View {
        HStack() {
            ZStack() {
                Text("@ home")
                    .if(isAtHome) { view in
                        view.bold()
                    }
                
                if isAtHome {
                    RoundedRectangle(cornerRadius: 50)
                        .strokeBorder(.black)
                        .frame(width: 92, height: 28)
                        .matchedGeometryEffect(id: "Selector", in: animation)
                }
            }
            .frame(width: 92, height: 28)
            
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.black)
                .frame(width: 3, height: 24)
                .padding(.horizontal, 20)
            
            ZStack() {
                Text("to buy")
                    .if(!isAtHome) { view in
                        view.bold()
                    }
                
                if !isAtHome {
                    RoundedRectangle(cornerRadius: 50)
                        .strokeBorder(.black)
                        .frame(width: 92, height: 28)
                        .matchedGeometryEffect(id: "Selector", in: animation)
                }
            }
            .frame(width: 92, height: 28)
            
        }
        .onTapGesture {
            withAnimation {
                isAtHome.toggle()
            }
        }
    }
}

struct KitchenToggle_Previews: PreviewProvider {
    static var previews: some View {
        KitchenToggle(isAtHome: .constant(true))
    }
}
