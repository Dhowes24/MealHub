//
//  KitchenTestNutritionGroup.swift
//  Food@Home
//
//  Created by Derek Howes on 10/19/23.
//

import SwiftUI

struct TestNutritionGroup: View {
    var foodItems: [FoodItem]
    var nutritionString: String
    var nutritionType: Int16
    
    init(foodItems: [FoodItem], nutritionType: Int16) {
        self.nutritionType = nutritionType
        self.foodItems = foodItems
        
        self.nutritionString = nutritionTypeToString(type: nutritionType)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text(nutritionString)
                .font(.title2)
            ForEach(foodItems) { item in
                if item.nutritionType == nutritionType {
                    HStack {
                        Text(item.name ?? "No Name")
                        Text("-")
                        Text(storageTypeToString(type: item.storageType))
                    }
                }
            }
        }
        .padding(.vertical, 20)
    }
}

#Preview {
    TestNutritionGroup(foodItems: [FoodItem()], nutritionType: 1)
}
