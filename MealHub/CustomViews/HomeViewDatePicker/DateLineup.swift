//
//  dateLineup.swift
//  MealHub
//
//  Created by Derek Howes on 12/14/23.
//

import SwiftUI

struct DateLineup: View {
    @ObservedObject var viewModel: HomeViewModel
    
    
    var body: some View {
        HStack {
            let thisWeekMonth = viewModel.dateLineup[0].formatted(.dateTime.month())
            let nextWeekMonth = viewModel.dateLineup[6].formatted(.dateTime.month())
            
            Text("\(thisWeekMonth) \(thisWeekMonth != nextWeekMonth ? "- \(nextWeekMonth)" : "")")
                .font(.customSystem(size: 16, weight: .bold))
            
            Spacer()
            
            Group {
                SFSymbols.chevron.getDirection(direction: "left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 6, height: 10)
                Text("Previous")
                    .font(.customSystem(size: 14, weight: .bold))
                    .padding(.trailing, 24)
            }
            .onTapGesture {
                withAnimation {
                    viewModel.updateWeekLineup(direction: -1)
                }
            }
            
            Group {
                Text("Next")
                    .font(.customSystem(size: 14, weight: .bold))
                SFSymbols.chevron.getDirection(direction: "right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 6, height: 10)
            }
            .onTapGesture {
                withAnimation {
                    viewModel.updateWeekLineup(direction: 1)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}


#Preview {
    DateLineup(viewModel: HomeViewModel())
}
