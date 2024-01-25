//
//  FilterSearch.swift
//  Food@Home
//
//  Created by Derek Howes on 1/18/24.
//

import SwiftUI
import WaterfallGrid

struct FilterSearch: View {
    
    @State private var filtersShowing: Bool = false
    @Binding var path: NavigationPath
    @State private var search: String = ""
        
    var body: some View {
        Group {
            
            HStack(alignment: .center) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .frame(width: 24, height: 24)
                        .padding(.horizontal, 8)
                    
                    TextField("Search Placeholder", text: $search)
                }
                .SearchInputMod()
                
                Image(systemName: filtersShowing ? "chevron.down" : "chevron.up")
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        withAnimation {
                            filtersShowing.toggle()
                        }
                    }
            }
            .frame(height: 23)
            .padding(.bottom, 24)
            
            VStack() {
                
                FilterSearchOption(title: "Ready In")
                
                FilterSearchOption(title: "Include/Exclude")
                
                FilterSearchOption(title: "Dietary Need")

                FilterSearchOption(title: "Cuisine")

            }
            .frame(height: filtersShowing ? nil : 0, alignment: .top)
            .disabled(!filtersShowing)
            .clipped()
            
        }
    }
}

#Preview {
    FilterSearch(path: Binding.constant(NavigationPath()))
}

