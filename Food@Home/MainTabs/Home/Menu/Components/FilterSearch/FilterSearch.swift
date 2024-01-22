//
//  FilterSearch.swift
//  Food@Home
//
//  Created by Derek Howes on 1/18/24.
//

import SwiftUI
import WaterfallGrid

struct FilterSearch: View {
    @State private var search: String = ""
    @State private var filtersShowing: Bool = true
    
    @Binding var path: NavigationPath

    init(path: Binding<NavigationPath>) {
        _path = path
        
        // create on this on onboarding
//        var tempDefaults = UserDefaults.standard
//
//        let readyIn: [Int: Bool] = [ 15: false, 30: false, 45: false, 1 : false, 2: false, 3: false, 0: true]
//        tempDefaults.set(readyIn, forKey: "readyIn")
//
//        defaults = tempDefaults
//        let includeExclude: [String : Bool] = [:]
//        defaults.set(includeExclude, forKey: "includeExclude")
//        
//        let diet: [String: Bool] = [
//            "pescetarian" : false,
//            "lacto%20vegetarian" : false,
//            "ovo%20vegetarian" : false,
//            "vegan" : false,
//            "paleo" : false,
//            "primal" : false,
//            "vegetarian" : false
//        ]
//        defaults.set(diet, forKey: "diet")
//        
//        let intolerances: [String: Bool] = [
//            "dairy" : false,
//            "egg" : false,
//            "gluten" : false,
//            "peanut": false,
//            "sesame": false,
//            "seafood" : false,
//            "shellfish" : false,
//            "soy" : false,
//            "sulfite" : false,
//            "tree%20nut" : false,
//            "wheat" : false
//        ]
//        defaults.set(intolerances, forKey: "intolerances")
//
//        let cuisine: [String : Bool] = [
//            "african" : false,
//            "chinese" : false,
//            "japanese" : false,
//            "korean" : false,
//            "vietnamese" : false,
//            "thai" : false,
//            "indian" : false,
//            "british" : false,
//            "irish" : false,
//            "french" : false,
//            "italian" : false,
//            "mexican" : false,
//            "spanish" : false,
//            "middle%20eastern" : false,
//            "jewish" : false,
//            "american" : false,
//            "cajun" : false,
//            "southern" : false,
//            "greek" : false,
//            "german" : false,
//            "nordic" : false,
//            "eastern%20european" : false,
//            "caribbean" : false,
//            "latin%20american" : false
//        ]
//        defaults.set(cuisine, forKey: "cuisine")

        //
    }
    
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

