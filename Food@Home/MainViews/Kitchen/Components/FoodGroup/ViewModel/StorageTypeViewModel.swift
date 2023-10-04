//
//  StorageTypeViewModel.swift
//  Food@Home
//
//  Created by Derek Howes on 6/13/23.
//

import Foundation
import SwiftUI

class StorageTypeViewModel: ObservableObject {
    @Published var headerColor: Color
    @Published var bodyColor: Color
    @Published var storageTypeName: String
    
    init(storageType: storageType) {
        
        switch storageType {
        case .protein:
            headerColor = freezerHead
            bodyColor = freezerBody
            storageTypeName = "Protein"
        case .starch:
            headerColor = fridgeHead
            bodyColor = fridgeBody
            storageTypeName = "Starch"
        case .veg:
            headerColor = pantryHead
            bodyColor = pantryBody
            storageTypeName = "Veg"
        case .other:
            headerColor = pantryHead
            bodyColor = pantryBody
            storageTypeName = "Other"
        }
    }
}
