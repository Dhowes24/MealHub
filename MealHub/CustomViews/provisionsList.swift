//
//  groceryListItem.swift
//  MealHub
//
//  Created by Derek Howes on 1/10/24.
//

import SwiftUI

struct provisionsList: View {
    @Binding var items: [FoodItem]
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
                     
                Image(systemName: selectAllBool ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(selectAllBool ? brandGreen : .gray)
                    .font(.system(size: 20, weight: .bold, design: .default))
                
            }
            .frame(height: 55)
            .onTapGesture {
                selectAllBool.toggle()
                selectAll(selectAllBool)
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
                    moveOrDeleteItems()
                }, label: {
                    Text("Delete Selected Items")
                        .button(color: "black", width: ownedItems ? CGFloat(350) : CGFloat(165))
                })
                .buttonStyle(.plain)
                .disabled(!itemsSelected())
                .padding(.bottom, 38)
                                
                if !ownedItems {
                    Button(action: {
                        moveOrDeleteItems(deleting: false)
                    }, label: {
                        Text("Add Items to Kitchen")
                            .button(color: "white", width: CGFloat(165))
                    })
                    .buttonStyle(.plain)
                    .disabled(!itemsSelected())
                    .padding(.bottom, 38)
                }
            }
        }
        .onChange(of: triggerRefresh) { _ in
            refreshPage()
        }
        .onChange(of: items) { _ in
            refreshPage()
        }
        .onChange(of: toggleItems) { _ in
            selectAllBool = allItemsSelected()
        }
        .onAppear(perform: {
            let filteredItems = items.filter { $0.owned == ownedItems}
            toggleItems = Dictionary(uniqueKeysWithValues: filteredItems.map { ($0, false) })
        })
    }
    
    
    private func allItemsSelected() -> Bool {
        !toggleItems.values.contains { Bool in Bool == false }
    }
    
    
    private func itemsSelected() -> Bool {
        toggleItems.values.contains { Bool in Bool == true }
    }
    
    
    @MainActor private func moveOrDeleteItems( deleting: Bool = true ) {
        var actionItemsArray: [FoodItem] = []
        
        toggleItems.forEach { (key: FoodItem, value: Bool) in
            if toggleItems[key] ?? false {
                actionItemsArray.append(key)
            }
        }
        if deleting {
            PersistenceController.shared.deleteFoodItems(itemsToDelete: actionItemsArray, allFoodItems: &items)
        } else {
            PersistenceController.shared.moveItemsToKitchen(itemsToMove: actionItemsArray)
        }
        triggerRefresh.toggle()
    }
    
    
    private func refreshPage() {
        let tempItems = toggleItems
        toggleItems.removeAll()
        
        let filteredItems = items.filter { $0.owned == ownedItems }
        filteredItems.forEach { item in
            if tempItems.keys.contains(item) {
                toggleItems[item] = tempItems[item]
            } else {
                toggleItems[item] = false
            }
        }
    }
    
    
    private func selectAll(_ bool: Bool) {
        for (key,_) in toggleItems {
            toggleItems[key] = bool
        }
    }
}


#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            provisionsList(items: .constant([]),
                           ownedItems: false)
        }
    }
    
    return PreviewWrapper()
}
