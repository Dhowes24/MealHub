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
        case .freezer:
            headerColor = freezerHead
            bodyColor = freezerBody
            storageTypeName = "Freezer"
        case .fridge:
            headerColor = fridgeHead
            bodyColor = fridgeBody
            storageTypeName = "Fridge"
        case .pantry:
            headerColor = pantryHead
            bodyColor = pantryBody
            storageTypeName = "Pantry"
        }
    }
}
