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
            
            ListToggle(listToggle: $viewModel.myKitchenShowing)
            
            Group {
                
                HStack(alignment: .center) {
                    TextField("Add Item to \(viewModel.myKitchenShowing ? "Kitchen" : "Grocery List")", text: $viewModel.newItemName)
                        .textInputMod()
                    
                    Button(action: {
                        viewModel.addItem(name: viewModel.newItemName, owned: viewModel.myKitchenShowing)
                        viewModel.newItemName = ""
                        
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
                    .disabled(viewModel.newItemName.isEmpty)
                }
                .padding(.vertical, 20)
                
                if viewModel.myKitchenShowing {
                    kitchenList(deleteItems: viewModel.deleteItems, items: $viewModel.items, moveItemsToKitchen: viewModel.moveItemsToKitchen)
                    
                } else {
                    groceryList(deleteItems: viewModel.deleteItems, items: $viewModel.items, moveItemsToKitchen: viewModel.moveItemsToKitchen)
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
