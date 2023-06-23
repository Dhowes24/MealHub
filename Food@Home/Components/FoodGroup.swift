//
//  FoodGroup.swift
//  Food@Home
//
//  Created by Derek Howes on 6/7/23.
//

import Foundation
import SwiftUI

struct FoodGroup: View {
    var groupName: String
    var groupItems: [String]
    
    var body: some View {
        VStack() {
            HStack() {
                Text(groupName)
                    .font(.system(size: 17, weight: .semibold))

                Spacer()
            }
            .padding(.horizontal, 35)
            .padding(.bottom, 26)
            if groupItems.isEmpty {
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 46, height: 4)
                    .padding(.bottom, 12)
            } else {
                VStack() {
                    ForEach(groupItems, id: \.self) { item in
                        HStack() {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 5, height: 5)
                            Text(item)
                                .font(.system(size: 14, weight: .regular))
                            Spacer()
                        }
                    }
                    
                }
                .padding(.horizontal, 50)
                
            }
        }
    }
}

struct FoodGroup_Previews: PreviewProvider {
    static var previews: some View {
        FoodGroup(groupName: "Protein", groupItems: [])
    }
}
