//
//  ReadyIn.swift
//  Food@Home
//
//  Created by Derek Howes on 1/18/24.
//
import WaterfallGrid
import SwiftUI

struct ReadyIn: View {
    
    @Binding var dict: [String: Bool]
    var decodeUserDefaults: () -> [String: Bool]
    var encodeUserDefaults: () -> Void
    
    var body: some View {
        
        GeometryReader { geo in
            VStack(alignment: .leading) {
                Text("Pick time")
                    .font(.customSystem(size: 23, weight: .bold))
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
        }
    }
    
//    private func decodeUserDefaults() -> [String: Bool] {
//        if let data = UserDefaults.standard.data(forKey: "Ready In"),
//           let decodedDictionary = try? PropertyListDecoder().decode([String: Bool].self, from: data) {
//            return decodedDictionary
//        } else {
//            return ["15": false, "30": false, "45": false, "60": false, "120": false, "180": true]
//        }
//    }
    
//    private func encodeUserDefaults() {
//        if let data = try? PropertyListEncoder().encode(readyInDict) {
//            UserDefaults.standard.set(data, forKey: "Ready In")
//        } else {
//            print("no worky")
//        }
//    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var bindingDict: [String: Bool] = ["15": false, "30": false, "45": false, "60": false, "120": false, "180": true]
        var body: some View {
            ReadyIn(dict: $bindingDict, decodeUserDefaults: {
                return ["15": true, "30": false, "45": true, "60": false, "120": true, "180": false]
            }, encodeUserDefaults: {})

        }
    }
    return PreviewWrapper()
}
