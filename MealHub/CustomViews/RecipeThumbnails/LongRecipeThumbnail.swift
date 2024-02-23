//
//  WeekReviewRecipeThumbnail.swift
//  MealHub
//
//  Created by Derek Howes on 1/5/24.
//

import CoreData
import SwiftUI

struct LongRecipeThumbnail: View {
    @Environment(\.colorScheme) var colorScheme

    @Binding var editMode: Bool
    var homeTab: Bool = false
    var meal: RecipeCD
    @Binding var path: NavigationPath
    @State var selected: Bool = false
    @Binding var selectedRecipes: [RecipeCD]
    
    
    var body: some View {
        HStack {
            Button(action: {
                if editMode {
                    selected.toggle()
                    if selected {
                        selectedRecipes.append(meal)
                    } else {
                        selectedRecipes.removeAll { RecipeCD in
                            RecipeCD == meal
                        }
                    }
                } else {
                    path.append(Recipe(id: Int(meal.apiID), title: meal.name ?? "Unknown", image: meal.imageURL ?? "Unknown"))
                }
            }, label: {
                HStack {
                    
                    ZStack {
                        AsyncImage(
                            url: URL(string: meal.imageURL ?? "Unknown"),
                            content: { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 65, height: 65)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 16.0)
                                    )
                            },
                            placeholder: {
                                ProgressView()
                                    .frame(width: 65, height: 65)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 16.0)
                                    )
                                    .background(brandColors.customGrey)
                            }
                        )
                        
                        if editMode {
                            Circle()
                                .foregroundStyle(colorScheme == .light ? .white : .black)
                                .frame(width: 25, height: 25)
                                .offset(x:25, y:-25)
                            
                            
                            SFSymbols.checkmarkCircle.fill(selected)
                                .foregroundStyle(selected ? brandColors.green.scheme(colorScheme) : brandColors.darkGrey)
                                .frame(width: 25, height: 25)
                                .offset(x:25, y:-25)
                        }
                    }
                    
                    VStack (alignment: .leading) {
                        Text(meal.name ?? "Unknown")
                            .font(.customSystem(size: 16, weight: .regular))
                        if(!homeTab) {
                            Text(meal.mealTime ?? "Unknown")
                                .foregroundStyle(brandColors.darkGrey)
                                .font(.customSystem(size: 12, weight: .semibold))
                        }
                        
                        Spacer()
                    }
                }
                .frame(height: 65)
                .padding(.bottom, 16)
            })
            .buttonStyle(.plain)

        }
        .onChange(of: editMode) { _ in
            if !editMode {
                selected = false
            }
        }
    }
}

//
//#Preview {
//    struct PreviewWrapper: View {
//        @FetchRequest(sortDescriptors: []) var meals: FetchedResults<RecipeCD>
//        var body: some View {
//            WeekReviewRecipeThumbnail(meal: meals.first,
//                                      path: Binding.constant(NavigationPath()))
//        }
//    }
//    return PreviewWrapper()
//}
