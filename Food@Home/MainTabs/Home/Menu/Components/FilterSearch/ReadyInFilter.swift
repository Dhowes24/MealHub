//
//  ReadyIn.swift
//  Food@Home
//
//  Created by Derek Howes on 1/18/24.
//
import WaterfallGrid
import SwiftUI

struct ReadyInFilter: View {
    
    var decodeUserDefaults: () -> [String: Bool]
    @Binding var dict: [String: Bool]
    @Environment(\.dismiss) private var dismiss
    var encodeUserDefaults: () -> Void
    
    var body: some View {
        
        GeometryReader { geo in
            VStack(alignment: .leading) {
                
                HStack {
                    Image(systemName: "arrow.backward")
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            dismiss()
                        }
                    
                    Spacer()
                    
                    Text("Pick time")
                        .font(.customSystem(size: 23, weight: .bold))
                    
                    Spacer()
                    
                    Rectangle()
                        .frame(width: 24, height: 24)
                        .opacity(0.0)
                }
                .padding(.vertical, 16)

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
                        
                        encodeUserDefaults()
                    }
                }
            }
            .onAppear(
                perform: {
                    self.dict = decodeUserDefaults()
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
            ReadyInFilter(decodeUserDefaults: {
                return ["15": true, "30": false, "45": true, "60": false, "120": true, "180": false]
            }, dict: $bindingDict, encodeUserDefaults: {})

        }
    }
    return PreviewWrapper()
}
