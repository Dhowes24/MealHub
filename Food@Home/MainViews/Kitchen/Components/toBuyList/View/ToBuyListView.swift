//
//  toBuyListView.swift
//  Food@Home
//
//  Created by Derek Howes on 6/14/23.
//

import SwiftUI

struct ToBuyListView: View {
    @ObservedObject var viewModel: ToBuyViewModel
    
    init() {
        viewModel = ToBuyViewModel()
    }
    
    var body: some View {
        VStack{
            ZStack(alignment: .top) {
                
                Group{
                        VStack(alignment: .leading, spacing: 18) {
                            
                            StorageType(groupName: "Protein", groupItems: [])
                            
                            StorageType(groupName: "Starch", groupItems: [])
                            
                            StorageType(groupName: "Veg", groupItems: [])
                            
                            StorageType(groupName: "Others", groupItems: [])
                        }
                        .padding(.vertical, 18)
                        .frame(width: UIScreen.screenWidth - 40)
                        .background(toBuyBody)
                        .cornerRadius(15)
                }
                
            }
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.black, lineWidth: 1)
            )
        }
    }

}

struct ToBuyListView_Previews: PreviewProvider {
    static var previews: some View {
        ToBuyListView()
    }
}
