//
//  groceryListItem.swift
//  MealHub
//
//  Created by Derek Howes on 1/10/24.
//

import SwiftUI

struct ProvisionsList: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State var viewModel: ProvisionsViewModel
    
    //    @Binding var items: [FoodItem]
    @State var ownedItems: Bool
    @State private var selectAllBool: Bool = false
    @State private var toggleItems: [FoodItem : Bool] = [:]
    @State var triggerRefresh: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                
                Text("Select All")
                    .font(.customSystem(size: 16, weight: .semibold))
                    .padding(.vertical, 16)
                
                Spacer()
                
                SFSymbols.checkmarkSquare.fill(selectAllBool)
                    .resizable()
                    .frame(width: 20, height:20)
                    .foregroundColor(selectAllBool ? brandColors.green.scheme(colorScheme) : .gray)
                    .font(.system(size: 20, weight: .bold, design: .default))
                
            }
            .frame(height: 55)
            .onTapGesture {
                withAnimation {
                    selectAllBool.toggle()
                    viewModel.selectAll(selectAllBool,toggleItems: &toggleItems)
                }
            }
            
            ScrollView(showsIndicators: false) {
                
                let enumeratedItems = Array(toggleItems.sorted(by: { $0.key < $1.key })).enumerated()
                
                ForEach(Array(enumeratedItems), id: \.element.key.id) { (index, element) in
                    let (item, _) = element
                    
                    if index > 0 {
                        SeparatorLine()
                    }
                    
                    ToggleListItem(controlKey: item, displayString: item.name ?? "Something else", dict: $toggleItems)
                }
                
            }
            .frame(maxWidth: .infinity)
            
            HStack(spacing: 20) {
                Button(action: {
                    viewModel.moveOrDeleteItems(toggleItems: &toggleItems)
                }, label: {
                    Text("Delete Selected Items")
                        .button(type: .primary, width: ownedItems ? CGFloat(350) : CGFloat(165))
                })
                .buttonStyle(.plain)
                .disabled(!viewModel.itemsSelected(toggleItems: toggleItems))
                .padding(.bottom, 38)
                
                if !ownedItems {
                    Button(action: {
                        viewModel.moveOrDeleteItems(deleting: false, toggleItems: &toggleItems)
                    }, label: {
                        Text("Add Items to Kitchen")
                            .button(type: .secondary, width: CGFloat(165))
                    })
                    .buttonStyle(.plain)
                    .disabled(!viewModel.itemsSelected(toggleItems: toggleItems))
                    .padding(.bottom, 38)
                }
            }
        }
        .onChange(of: triggerRefresh) { _ in
            viewModel.refreshPage(ownedItems: ownedItems, toggleItems: &toggleItems)
        }
        .onChange(of: viewModel.items) { _ in
            viewModel.refreshPage(ownedItems: ownedItems, toggleItems: &toggleItems)
        }
        .onChange(of: toggleItems) { _ in
            selectAllBool = viewModel.allItemsSelected(toggleItems: toggleItems)
        }
        .onAppear(perform: {
            let filteredItems = viewModel.items.filter { $0.owned == ownedItems}
            toggleItems = Dictionary(uniqueKeysWithValues: filteredItems.map { ($0, false) })
        })
    }
}


#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            ProvisionsList(
                viewModel: ProvisionsViewModel(),
                ownedItems: false
            )
        }
    }
    
    return PreviewWrapper()
}
