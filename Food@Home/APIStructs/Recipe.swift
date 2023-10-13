//
//  Recipe.swift
//  Food@Home
//
//  Created by Derek Howes on 10/10/23.
//

import Foundation

struct Response: Codable {
    var results: [Recipe]
}

struct Recipe: Codable, Identifiable {
    var id: Int
    var title: String
    var image: String
}
