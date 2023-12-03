//
//  ItemEditorView.swift
//  Food@Home
//
//  Created by Derek Howes on 10/15/23.
//

import SwiftUI

struct ItemEditorView: View {
    @Binding var showEditor: Bool
    @State private var name: String = ""
    @State private var storage: StorageTypeEnum = .freezer
    @State private var nutrition: NutritionTypeEnum = .other
    @FocusState var textIsFocused: Bool
    
    var addFoodItem: (String, StorageTypeEnum, NutritionTypeEnum) -> Void
    
    var body: some View {
        ScrollView {
            Text("Close")
                .onTapGesture {
                    withAnimation {
                        showEditor = false
                    }
                }
            
            TextField("Enter Item Name...", text: $name, axis: .vertical)
                .padding()
                .cornerRadius(5)
                .padding(10)
                .focused($textIsFocused)
                .onTapGesture {
                    textIsFocused = true
                }
            
            HStack {
                Text("Storage Type:")
                Picker("",selection: $storage) {
                    ForEach(StorageTypeEnum.allCases, id: \.self) { option in
                        Text(String(describing: option))
                    }
                }.pickerStyle(.segmented)
            }
            .padding(10)
            
            HStack {
                Text("Nutrition Type:")
                Picker("",selection: $nutrition) {
                    ForEach(NutritionTypeEnum.allCases, id: \.self) { option in
                        Text(String(describing: option))
                    }
                }.pickerStyle(.segmented)
            }
            .padding(10)
            
            Button {
                addFoodItem(name, storage, nutrition)
                showEditor = false
            } label: {
                Text("Save Item")
            }
            .disabled(name.isEmpty)
        }
        .frame(minWidth: UIScreen.screenWidth-60, maxHeight: UIScreen.screenHeight/2)
        .padding()
        .background(
            RoundedRectangle(cornerSize: CGSize(width: 25, height: 25))
                .fill(.white)
                .shadow(radius: 5)
        )
        .padding()
        .onChange(of: showEditor) { _ in
            resetDefaults()
        }
    }
    
    func resetDefaults() {
        name = ""
        storage = .freezer
        nutrition = .other
    }
}

#Preview {
    ItemEditorView(showEditor: .constant(true))
    { _,_,_ in
        print("just a preview")
    }
}
