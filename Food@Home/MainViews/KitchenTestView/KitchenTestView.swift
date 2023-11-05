//
//  KitchenTestView.swift
//  Food@Home
//
//  Created by Derek Howes on 10/15/23.
//

import SwiftUI

struct KitchenTestView: View {
//    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject var viewModel: FoodItemsAccess
    
    var body: some View {
        
        GeometryReader { screen in
            VStack(alignment: .center) {
                
                Spacer()

                Button {
                    withAnimation {
                        viewModel.showEditor.toggle()
                    }
                } label: {
                    Text("Add Item")
                }
                
                Spacer()
                
                TestNutritionGroup(foodItems: viewModel.foodItems, nutritionType: 1)
                TestNutritionGroup(foodItems: viewModel.foodItems, nutritionType: 2)
                TestNutritionGroup(foodItems: viewModel.foodItems, nutritionType: 3)
                TestNutritionGroup(foodItems: viewModel.foodItems, nutritionType: 4)

                Spacer()
                
                Button {
                    viewModel.removeCoreDataInfo()
                } label: {
                    Text("Clear Core Data")
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            ZStack(alignment: .center){
                Color.black.opacity(viewModel.showEditor ? opacityVal : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            viewModel.showEditor = false
                        }
                    }
                ItemEditorView(showEditor: $viewModel.showEditor, addFoodItem: viewModel.addFoodItem)
                    .offset(x: viewModel.showEditor ? 0: UIScreen.screenWidth)
            }
            .opacity(viewModel.showEditor  ? 1 : 0)
        }
    }
}

#Preview {
    KitchenTestView()
}
