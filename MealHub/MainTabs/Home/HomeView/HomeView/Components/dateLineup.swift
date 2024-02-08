//
//  dateLineup.swift
//  MealHub
//
//  Created by Derek Howes on 12/14/23.
//

import SwiftUI

struct dateLineup: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        HStack {
            let thisWeekMonth = viewModel.dateLineup[0].formatted(.dateTime.month())
            let nextWeekMonth = viewModel.dateLineup[6].formatted(.dateTime.month())
            
            Text("\(thisWeekMonth) \(thisWeekMonth != nextWeekMonth ? "- \(nextWeekMonth)" : "")")
                .font(.customSystem(size: 16, weight: .bold))
            
            Spacer()
            
            Group {
                Image(systemName: "arrow.backward")
                    .frame(width: 24, height: 24)
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
                Image(systemName: "arrow.forward")
                    .frame(width: 24, height: 24)
            }
            .onTapGesture {
                withAnimation {
                    viewModel.updateWeekLineup(direction: 1)
                }
            }
        }
        .padding(.horizontal, 17)
        .padding(.bottom, 22)
    }
}

#Preview {
    dateLineup(viewModel: HomeViewModel())
}
