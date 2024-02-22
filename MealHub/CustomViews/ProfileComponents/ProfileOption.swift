//
//  ProfileOption.swift
//  MealHub
//
//  Created by Derek Howes on 1/27/24.
//

import SwiftUI

struct ProfileOption: View {
    var profileOptionDetails: ProfileOptionDetails
    @Binding var path: NavigationPath
    
    init(_ profileOptionDetails: ProfileOptionDetails, path: Binding<NavigationPath>) {
        self.profileOptionDetails = profileOptionDetails
        self._path = path
    }
    
    var body: some View {
        Button {
            path.append(profileOptionDetails)
        } label: {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(profileOptionDetails.title)
                            .font(.customSystem(size: 16, weight: .semibold))
                        Text(profileOptionDetails.subText)
                            .font(.customSystem(size: 13, weight: .regular))
                            .foregroundStyle(brandColors.darkGrey)
                    }
                    Spacer()
                    
                    SFSymbols.chevron.getDirection(direction: "right")
                }
                .padding(.vertical, 16)
                
                SeparatorLine()
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ProfileOption(ProfileOptionDetails(title: "Saved Recipes", subText: "Your favorited"), path: .constant(NavigationPath()))
}


struct ProfileOptionDetails: Hashable {
    var title: String
    var subText: String
}
