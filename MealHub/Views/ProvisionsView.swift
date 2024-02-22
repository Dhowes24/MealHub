//
//  ProvisionsView.swift
//  MealHub
//
//  Created by Derek Howes on 1/9/24.
//

import SwiftUI

struct ProvisionsView: View {
    @ObservedObject private var viewModel: ProvisionsViewModel = ProvisionsViewModel()
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Provisions")
                    .font(.customSystem(size: 30, weight: .bold))
                
                Spacer()
            }
            .padding(.horizontal, 16)
            
            ListToggle(listToggle: $viewModel.myKitchenShowing, optionOne: "Kitchen", optionTwo: "Grocery List")
            
            Group {
                AddItemInput(
                    optionOne: "Kitchen",
                    optionTwo: "Grocery List", 
                    optionOneSelected: viewModel.myKitchenShowing,
                    itemName: $viewModel.newItemName,
                    addItemFunction: viewModel.addItem,
                    disabled: viewModel.newItemName.isEmpty
                )
                
                if viewModel.myKitchenShowing {
                    ProvisionsList(items: $viewModel.items,
                                   ownedItems: true)
                } else {
                    ProvisionsList(items: $viewModel.items,
                                   ownedItems: false)
                }
            }
            .padding(.horizontal, 16)
            
            Spacer()
            
            SeparatorLine()
        }
        .padding(.top, 6)
    }
}


#Preview {
    ProvisionsView()
}
