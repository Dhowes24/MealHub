//
//  SeparatorLine.swift
//  MealHub
//
//  Created by Derek Howes on 12/1/23.
//

import SwiftUI

struct SeparatorLine: View {
    var body: some View {
            Rectangle()
                .fill(customGrey)
                .frame(minWidth: 0,maxWidth: .infinity,minHeight: 1,maxHeight: 1,alignment: .center)
    }
}

#Preview {
    SeparatorLine()
}
