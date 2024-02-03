//
//  ProfileOption.swift
//  Food@Home
//
//  Created by Derek Howes on 1/27/24.
//

import SwiftUI

struct ProfileOption: View {
    var title: String
    var subText: String
    
    var body: some View {
        NavigationLink(destination: chooseView(viewTitle: title)) {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.customSystem(size: 16, weight: .semibold))
                        Text(subText)
                            .font(.customSystem(size: 13, weight: .regular))
                            .foregroundStyle(darkGrey)
                    }
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                }
                .padding(.vertical, 16)
                
                SeparatorLine()
            }
        }
        .buttonStyle(.plain)
    }
    
    
    private func chooseView(viewTitle: String) -> some View {
        switch viewTitle {
        case "Food Profile":
            return AnyView(FoodProfileView())
        case "Saved Recipes":
            return AnyView(SavedRecipesView())
        case "Resources":
            return AnyView(ResourcesView())
        case "Preferences":
            return AnyView(PreferencesView())
        default:
            return AnyView(FoodProfileView())
        }
    }
}

#Preview {
    ProfileOption(title: "Food Profile", subText: "Nutrition goals, intolerances, dietary types")
}
