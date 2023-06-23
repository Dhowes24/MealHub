//
//  AddItemModal.swift
//  Food@Home
//
//  Created by Derek Howes on 6/22/23.
//

import SwiftUI

struct AddItemModalView: View {
    @State private var itemName: String = ""
    enum foodTypes: String, CaseIterable {
        case protein, starch, veg, other
    }
    @State private var selectedFoodType: foodTypes = .protein
    
    enum storageTypes:String, CaseIterable {
        case freezer, fridge, pantry
    }
    @State private var selectedStorageType: storageTypes = .freezer

    
    var body: some View {
        VStack(alignment: .center, spacing: 45) {
            Group {
                Text("Add Item\nto buy")
            }
            .font(.system(size: 23, weight: .heavy))
            .multilineTextAlignment(.center)
            
            HStack {
                Text("item name:")
                    .font(.system(size: 14, weight: .regular))
                    .padding()


                TextField("Type here...", text: $itemName)
                    .font(.system(size: 12, weight: .regular))
                    .padding(6)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .strokeBorder(.black, lineWidth: 0.5)
                            .background(RoundedRectangle(cornerRadius: 4).fill(defaultGray))
                    )
                    .padding(5)
            }
            
            HStack {
                Picker("", selection: $selectedFoodType) {
                    ForEach(foodTypes.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding()
            
            HStack {
                Picker("", selection: $selectedStorageType) {
                    ForEach(storageTypes.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding()
            
            Button() {
                print("Added")
            } label: {
                Text("Add")
                    .font(.system(size: 23, weight: .heavy))
                    .foregroundColor(.black)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 40)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .strokeBorder(.black, lineWidth: 0.5)
                            .background(RoundedRectangle(cornerRadius: 14).fill(defaultGray))
                    )
            }
        }
        .padding(20)
        .background(defaultWhite)
        .padding()
    }
}

struct AddItemModalView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemModalView()
    }
}
