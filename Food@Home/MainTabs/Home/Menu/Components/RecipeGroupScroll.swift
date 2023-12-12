//
//  RecipeGroupScroll.swift
//  Food@Home
//
//  Created by Derek Howes on 12/1/23.
//

import SwiftUI

struct RecipeGroupScroll: View {
    var selectedDate: Date
    var groupName: String
    var recipeList: [Recipe]
    
    @Binding var path: NavigationPath
    var body: some View {
        Group {
            HStack {
                Text(groupName)
                    .font(.customSystem(size: 24, weight: .semibold))
                Spacer()
            }
            .frame(height: 30)
            .padding(.bottom, 24)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 20) {
                    ForEach(recipeList) {recipe in
                        Button(action: {
                            path.append(recipe)
                        }, label: {
                            RecipeThumbnail(recipe: recipe)
                        })
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.bottom, 30)
        }
    }
}

//#Preview {
//    RecipeGroupScroll(groupName: "Breakfast foods", recipeList: <#[Recipe]#>)
//}
