//
//  SavedRecipesView.swift
//  Food@Home
//
//  Created by Derek Howes on 1/27/24.
//

import SwiftUI
import CoreData

struct SavedRecipesView: View {
    let columns = [
        GridItem(.adaptive(minimum: 160))
    ]
    @Environment(\.managedObjectContext) var moc
    @Binding var path: NavigationPath
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \SavedRecipes.dateSaved, ascending: false)]) var savedRecipes: FetchedResults<SavedRecipes>
    @State private var showTabBar: Bool  = false
    
    var body: some View {
        subViewHeader(headerText: "Saved Recipes")

        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(savedRecipes) {SavedRecipe in
                        ShortRecipeThumbnail(
                            recipe: Recipe(
                                id: Int(SavedRecipe.apiID),
                                title: SavedRecipe.name ?? "",
                                image: SavedRecipe.imageURL ?? ""
                            ), path: $path
                        )
                    }
                }
                .padding(.horizontal)
            }
            .padding(.horizontal, 16)
            .navigationBarBackButtonHidden(true)
            .toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
            
            Spacer()
        }
    }
}

#Preview {
    SavedRecipesView(path: .constant(NavigationPath()))
}
