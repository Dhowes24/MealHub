//
//  ProvisionsView.swift
//  Food@Home
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
            .onTapGesture {
                viewModel.deleteAll()
            }
            
            ListToggle(listToggle: $viewModel.myKitchenShowing, optionOne: "Kitchen", optionTwo: "Grocery List")
            
            Group {
                addItemInput(
                    optionOne: "Kitchen",
                    optionTwo: "Grocery List", optionOneSelected: viewModel.myKitchenShowing,
                    itemName: $viewModel.newItemName,
                    addItemFunction: viewModel.addItem,
                    disabled: viewModel.newItemName.isEmpty
                )
                
                if viewModel.myKitchenShowing {
                    provisionsList(deleteItems: viewModel.deleteItems, items: $viewModel.items, moveItemsToKitchen: viewModel.moveItemsToKitchen, ownedItems: true)
                    
                } else {
                    provisionsList(deleteItems: viewModel.deleteItems, items: $viewModel.items, moveItemsToKitchen: viewModel.moveItemsToKitchen, ownedItems: false)
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
