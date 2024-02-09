//
//  WeekReviewRecipeThumbnail.swift
//  MealHub
//
//  Created by Derek Howes on 1/5/24.
//

import CoreData
import SwiftUI

struct LongRecipeThumbnail: View {
    @Binding var editMode: Bool
    var homeTab: Bool = false
    var meal: RecipeCD
    @Environment(\.managedObjectContext) var moc
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
                                    .background(customGrey)
                            }
                        )
                        
                        if editMode {
                            Circle()
                                .foregroundStyle(.white)
                                .frame(width: 25, height: 25)
                                .offset(x:25, y:-25)
                            
                            Image(systemName: selected ? "checkmark.circle.fill" : "checkmark.circle")
                                .foregroundStyle(selected ? brandGreen : darkGrey)
                                .frame(width: 25, height: 25)
                                .offset(x:25, y:-25)
                        }
                    }
                    
                    VStack (alignment: .leading) {
                        Text(meal.name ?? "Unknown")
                            .font(.customSystem(size: 16, weight: .regular))
                        if(!homeTab) {
                            Text(meal.mealTime ?? "Unknown")
                                .foregroundStyle(darkGrey)
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
