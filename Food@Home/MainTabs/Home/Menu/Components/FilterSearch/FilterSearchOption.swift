//
//  FilterSearchOption.swift
//  Food@Home
//
//  Created by Derek Howes on 1/21/24.
//

import SwiftUI

struct FilterSearchOption: View {
    var title: String
    
    @State private var filterDict: [String: Bool] = [:]
    
    init(title: String) {
        self.title = title
        
        _filterDict = State(initialValue: decodeUserDefaults())
        
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.customSystem(size: 16, weight: .semibold))
            
            Spacer()
            
            NavigationLink(destination: chooseView()) {
                Text("Edit")
                    .frame(width: 45, height: 24)
                    .button(color: "grey")
            }
            .buttonStyle(.plain)
        }
        .frame(height: 55)
        
        SeparatorLine()
    }
    
    private func decodeUserDefaults() -> [String: Bool] {
        if let data = UserDefaults.standard.data(forKey: title),
           let decodedDictionary = try? PropertyListDecoder().decode([String: Bool].self, from: data) {
            return decodedDictionary
        } else {
            return ["15": false, "30": false, "45": false, "60": false, "120": false, "180": true]
        }
    }
    
    private func encodeUserDefaults() {
        if let data = try? PropertyListEncoder().encode(filterDict) {
            UserDefaults.standard.set(data, forKey: title)
        } else {
            print("no worky")
        }
    }
    
    private func chooseView() -> some View {
        switch title {
        case "Ready In":
            return AnyView(ReadyIn(dict: $filterDict, decodeUserDefaults: decodeUserDefaults, encodeUserDefaults: encodeUserDefaults))
        case "Include/Exclude":
            return AnyView(IncludeExcludeFilter(dict: $filterDict, decodeUserDefaults: decodeUserDefaults, encodeUserDefaults: encodeUserDefaults))
        default:
            return AnyView(ReadyIn(dict: $filterDict, decodeUserDefaults: decodeUserDefaults, encodeUserDefaults: encodeUserDefaults))
        }
    }
}

//#Preview {
//    struct PreviewWrapper: View {
//        @State var bindingDict: [String: Bool] = ["15": false, "30": false, "45": false, "60": false, "120": false, "180": true]
//        var body: some View {
//            FilterSearchOption(title: "Ready In") {
//                ReadyIn(dict: $bindingDict, decodeUserDefaults: {
//                    return ["15": true, "30": false, "45": true, "60": false, "120": true, "180": false]
//                }, encodeUserDefaults: {})            }
//
//        }
//    }
//    return PreviewWrapper()
//}
