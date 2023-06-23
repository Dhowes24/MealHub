//
//  ContentView.swift
//  Food@Home
//
//  Created by Derek Howes on 6/6/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAtHome: Bool = true
    @State private var showAddItemModal: Bool = false
    @State private var freezerCollapsed: Bool = true
    @State private var fridgeCollapsed: Bool = true
    @State private var pantryCollapsed: Bool = true
    
    var body: some View {
        ZStack{
            ScrollView {
                
                KitchenToggle(isAtHome: $isAtHome)
                
                HStack() {
                    Spacer()
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            showAddItemModal = true
                        }
                }
                .padding(35)
                Group {
                    if isAtHome{
                        
                        VStack(spacing: 40) {
                            StorageTypeView(storageType: storageType.freezer, collapsed: $freezerCollapsed)
                            
                            StorageTypeView(storageType: storageType.fridge, collapsed: $fridgeCollapsed)
                            
                            StorageTypeView(storageType: storageType.pantry, collapsed: $pantryCollapsed)
                        }
                    } else {
                        VStack(spacing: 40) {
                            ToBuyListView()
                        }
                    }
                }
                .transition(.asymmetric(insertion: isAtHome ? .slide : .backslide, removal: isAtHome ? .backslide : .slide))
                
            }
            .padding()
            
            if showAddItemModal {
                Rectangle()
                    .fill(defaultGray)
                    .frame(width: .infinity, height: .infinity)
                    .ignoresSafeArea()
                    .opacity(0.6)
                    .onTapGesture {
                        showAddItemModal.toggle()
                    }
                AddItemModalView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
