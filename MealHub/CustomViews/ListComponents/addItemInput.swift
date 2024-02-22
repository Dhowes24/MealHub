//
//  addItemInput.swift
//  MealHub
//
//  Created by Derek Howes on 1/21/24.
//

import SwiftUI

struct addItemInput: View {
    var optionOne: String
    var optionTwo: String
    var optionOneSelected: Bool
    
    @Binding var itemName: String
    var addItemFunction: @MainActor (Date, String, Bool) -> Void
    var disabled: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            TextField("Add Item to \(optionOneSelected ? optionOne : optionTwo)", text: $itemName)
                .textInputMod()
            
            Button(action: {
                addItemFunction(Date(), itemName, optionOneSelected)
                itemName = ""
                
            }, label: {
                Text("Add")
                    .font(.customSystem(size: 14, weight: .bold))
                    .foregroundStyle(.white)
                    .background(
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .frame(width: 50, height: 30)
                    )
                    .frame(width: 50, height: 30)
                
            })
            .buttonStyle(.plain)
            .disabled(disabled)
        }
        .padding(.vertical, 20)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var bindingBool: Bool = true
        @State var bindingString: String = ""
        var body: some View {
            addItemInput(
                optionOne: "Kitchen",
                optionTwo: "Grocery List",
                optionOneSelected: bindingBool,
                itemName: $bindingString,
                addItemFunction: {_,_,_ in },
                disabled: bindingString.isEmpty)
        }
    }
    return PreviewWrapper()
}
