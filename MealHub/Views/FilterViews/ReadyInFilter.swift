//
//  ReadyIn.swift
//  MealHub
//
//  Created by Derek Howes on 1/18/24.
//
import SwiftUI
import WrappingHStack

struct ReadyInFilter: View {
    @Binding var dict: [String: Bool]
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        SubViewHeader(headerText: "Pick time")
        
        VStack(alignment: .leading) {
            Text("Ready in less than")
                .font(.customSystem(size: 14, weight: .bold))
                .padding(.vertical, 24)
            
            let enumeratedItems = Array(dict.sorted(by: { Int($0.key) ?? 1 < Int($1.key) ?? 1 })).enumerated()
            let arrayEnumeratedItems = Array(enumeratedItems)
            
            WrappingHStack(arrayEnumeratedItems, id: \.self, spacing: .constant(22), lineSpacing: 16.0) { (index, element) in
                Group {
                    if element.value == true {
                        HStack {
                            Text("\(element.key.description) minutes")
                                .font(.customSystem(size: 14, weight: .bold))
                                .foregroundStyle(colorScheme == .light ? brandColors.offWhite : .black)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 13)
                                .background(
                                    Capsule()
                                )
                        }
                    } else {
                        HStack {
                            Text("\(element.key.description) minutes")
                                .font(.customSystem(size: 14, weight: .bold))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 13)
                                .overlay(
                                    Capsule()
                                        .stroke(brandColors.customGrey, lineWidth: 1)
                                )
                        }
                    }
                }
                .onTapGesture {
                    dict.keys.forEach { key in
                        dict[key] = false
                    }
                    dict[element.key] = !element.value
                    
                    encodeUserDefaults(filterDict: dict, keyString: "Ready In")
                }
            }
            
            Spacer()
            
        }
        .padding(.horizontal, 16)
        .onAppear(
            perform: {
                self.dict = decodeUserDefaults("Ready In")
            }
        )
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    struct PreviewWrapper: View {
        @State var bindingDict: [String: Bool] = ["15": false, "30": false, "45": false, "60": false, "120": false, "180": true]
        var body: some View {
            ReadyInFilter(dict: $bindingDict)
        }
    }
    return PreviewWrapper()
}
