//
//  ReadyIn.swift
//  Food@Home
//
//  Created by Derek Howes on 1/18/24.
//
import WaterfallGrid
import SwiftUI

struct ReadyInFilter: View {
    @Binding var dict: [String: Bool]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        GeometryReader { geo in
            VStack(alignment: .leading) {
                
                filterHeader(headerText: "Pick time")

                Text("Ready in less than")
                    .font(.customSystem(size: 14, weight: .bold))
                    .padding(.bottom, 24)
                
                let enumeratedItems = Array(dict.sorted(by: { Int($0.key) ?? 1 < Int($1.key) ?? 1 })).enumerated()
                let arrayEnumeratedItems = Array(enumeratedItems)
                
                ForEach(arrayEnumeratedItems, id: \.element.key)  { (index, element) in
                    Group {
                        if element.value == true {
                            HStack {
                                Text("\(element.key.description) minutes")
                                    .font(.customSystem(size: 14, weight: .bold))
                                    .foregroundStyle(offWhite)
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
                                            .stroke(customGrey, lineWidth: 1)
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
            }
            .onAppear(
                perform: {
                    self.dict = decodeUserDefaults("Ready In")
                }
            )
            .navigationBarBackButtonHidden(true)
        }
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
