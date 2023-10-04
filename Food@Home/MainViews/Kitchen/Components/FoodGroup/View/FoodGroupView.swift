//
//  StorageType.swift
//  Food@Home
//
//  Created by Derek Howes on 6/7/23.
//

import SwiftUI

struct FoodGroupView: View {
    @ObservedObject var viewModel: StorageTypeViewModel
    @Binding var collapsed: Bool
    
    init(storageType: storageType, collapsed: Binding<Bool>) {
        _collapsed = collapsed
        viewModel = StorageTypeViewModel(storageType: storageType)
    }
    
    var body: some View {
        VStack{
            ZStack(alignment: .top) {
                
                Group{
                    if !collapsed {
                        VStack(alignment: .leading, spacing: 18) {
                            
                            StorageType(groupName: "Freezer", groupItems: [])
                            
                            StorageType(groupName: "Fridge", groupItems: [])
                            
                            StorageType(groupName: "Pantry", groupItems: [])
                            
                        }
                        .padding(.top, 38)
                        .padding(.bottom, 18)
                        .frame(width: UIScreen.screenWidth - 40)
                        .background(viewModel.bodyColor)
                        .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                        .scaleEffect(y:collapsed ? 0 : 1, anchor: .top)
                        .offset(y: 20)
                        .padding(.bottom, 20)
                    }
                }

                ZStack(alignment: .leading) {
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(viewModel.headerColor)
                    HStack() {
                        Text(viewModel.storageTypeName)
                            .font(.system(size: 25, weight: .bold))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .resizable()
                            .frame(width: 19, height: 10)
                            .rotationEffect((collapsed ? .degrees(0) : .degrees(-180)))
                    }
                    .padding(.horizontal, 15)
                    
                }
                .frame(width: UIScreen.screenWidth - 40, height: 40)
                .onTapGesture {
                    withAnimation {
                        collapsed.toggle()
                    }
                }
                
            }
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.black, lineWidth: 1)
            )
        }
    }
}

enum storageType {
    case protein, starch, veg, other
}

struct StorageType_Previews: PreviewProvider {
    static var previews: some View {
        FoodGroupView(storageType: storageType.protein, collapsed: .constant(true))
    }
}
