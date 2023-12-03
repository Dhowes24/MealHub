//
//  AccountTestView.swift
//  Food@Home
//
//  Created by Derek Howes on 10/24/23.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var viewModel: FoodItemsAccess

    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: SelectorView(listName: "diets")) {
                    Text("Diets")
                }
                NavigationLink(destination: SelectorView(listName: "intolerances")) {
                    Text("intolerances")
                }
            }
        }
    }
}

#Preview {
    AccountView()
}
