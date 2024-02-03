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
                    
                    ProfileOption(title: "Food Profile", subText: "Nutrition goals, intolerances, dietary types")
                    
                    ProfileOption(title: "Saved Recipes", subText: "Your favorited")
                    
                    ProfileOption(title: "Resources", subText: "Guides and articles on how to meal plan")

                    ProfileOption(title: "Preferences", subText: "Edit what you see when meal planning")
                }
                
                Spacer()
                
            }
            .padding(.horizontal, 16)
            .navigationDestination(for: ArticleInformation.self) { articleInformation in
                GuideTemplate(articleInfo: articleInformation)
            }
            
            SeparatorLine()
        }
    }
}

#Preview {
    ProfileView()
}
