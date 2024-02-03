//
//  kitchenList.swift
//  Food@Home
//
//  Created by Derek Howes on 1/16/24.
//

import SwiftUI

struct kitchenList: View {
    var deleteItems: @MainActor ([FoodItem]) -> Void
    @Binding var items: [FoodItem]
    var moveItemsToKitchen: @MainActor ([FoodItem]) -> Void
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
                    .foregroundColor(selectAllBool ? .purple : .gray)
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
                    
                    HStack {
                        Text(item.name ?? "Something else")
                            .font(.customSystem(size: 16, weight: .semibold))
                            .padding(.vertical, 16)
                        
                        Spacer()
                        
                        Toggle(isOn: binding(for: item)) {
                        }
                        .toggleStyle(CheckboxStyle())
                    }
                    .frame(height: 55)
                }
            }
            .frame(maxWidth: .infinity)
            
            Button(action: {
                var deleteItemsArray: [FoodItem] = []
                toggleItems.forEach { (key: FoodItem, value: Bool) in
                    if toggleItems[key] ?? false {
                        deleteItemsArray.append(key)
                    }
                }
                deleteItems(deleteItemsArray)
                triggerRefresh.toggle()
            }, label: {
                Text("Delete Selected Items")
                    .button(color: "black")
            })
            .buttonStyle(.plain)
            .disabled(!itemsSelected())
            .padding(.bottom, 38)
            
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
            let filteredItems = items.filter { $0.owned }
            toggleItems = Dictionary(uniqueKeysWithValues: filteredItems.map { ($0, false) })
        })
    }
    
    private func allItemsSelected() -> Bool {
        !toggleItems.values.contains { Bool in Bool == false }
    }
    
    private func binding(for key: FoodItem) -> Binding<Bool> {
        return Binding(get: {
            return toggleItems[key] ?? false
        }, set: {
            toggleItems[key] = $0
        })
    }
    
    private func itemsSelected() -> Bool {
        toggleItems.values.contains { Bool in Bool == true }
    }
    
    private func refreshPage() {
        let tempItems = toggleItems
        toggleItems.removeAll()
        
        let filteredItems = items.filter { $0.owned }
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

//#Preview {
//    kitchenList()
//}
