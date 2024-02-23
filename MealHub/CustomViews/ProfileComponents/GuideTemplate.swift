//
//  MealPrepGuide.swift
//  MealHub
//
//  Created by Derek Howes on 2/2/24.
//

import SwiftUI

struct GuideTemplate: View {
    var articleInfo: ArticleInformation
    @GestureState private var zoom = 1.0
    
    var body: some View {
        GeometryReader { proxy in
            
            ScrollView(.vertical) {
                SubViewHeader(headerText: "")

                VStack(alignment: .leading, spacing: 24) {
                    
                    HStack{
                        Text(articleInfo.title)
                            .font(.customSystem(size: 32, weight: .semibold))
                        
                        Spacer()
                    }
                    
                    HStack{
                        Text(articleInfo.subTitle)
                            .font(.customSystem(size: 16))
                            .foregroundStyle(brandColors.darkGrey)
                        
                        Spacer()
                    }
                    if articleInfo.articleBlocks.isEmpty {
                        Image("EatingPlan")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                    } else {
                        ForEach(articleInfo.articleBlocks, id: \.self) { block in
                            Group{
                                VStack(alignment: .leading) {
                                    Text(block.blockTitle)
                                        .font(.customSystem(size: 26, weight: .bold))
                                    
                                    ForEach(block.blockBullets, id: \.self) {bullet in
                                        HStack(alignment: .top) {
                                            Circle()
                                                .frame(width: 6)
                                                .offset(y: 6)
                                            
                                            Text(bullet)
                                                .font(.customSystem(size: 16))
                                            
                                            Spacer()
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(24)
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 16.0)
                                    .foregroundColor(brandColors.lightGrey)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 16.0)
                                    .stroke(brandColors.customGrey)
                            )
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GuideTemplate(articleInfo: wellBalancedMeal)
}
