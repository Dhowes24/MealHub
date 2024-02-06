//
//  AccountTestView.swift
//  Food@Home
//
//  Created by Derek Howes on 10/24/23.
//

import SwiftUI

struct ProfileView: View {
    @State var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HStack {
                    Text("Profile")
                        .font(.customSystem(size: 32, weight: .bold))

                    Spacer()
                }
                .padding(.vertical, 40)
                
                VStack(alignment: .leading) {
                    ProfileOption(ProfileOptionDetails(title: "Food Profile", subText: "Nutrition goals, intolerances, dietary types"), path: $path)
                    
                    ProfileOption(ProfileOptionDetails(title: "Saved Recipes", subText: "Your favorited"), path: $path)
                    
                    ProfileOption(ProfileOptionDetails(title: "Resources", subText: "Guides and articles on how to meal plan"), path: $path)

                    ProfileOption(ProfileOptionDetails(title: "Preferences", subText: "Edit what you see when meal planning"), path: $path)
                }
                
                Spacer()
                
            }
            .padding(.horizontal, 16)
            .modifier(ProfileNavStackViewMod(path: $path))
            
            SeparatorLine()
        }
    }
}

#Preview {
    ProfileView()
}
