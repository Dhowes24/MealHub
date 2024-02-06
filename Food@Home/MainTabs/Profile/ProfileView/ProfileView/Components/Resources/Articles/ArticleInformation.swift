//
//  ArticleInformation.swift
//  Food@Home
//
//  Created by Derek Howes on 2/2/24.
//

import Foundation

struct ArticleInformation: Hashable {
    var title: String
    var subTitle: String
    var articleBlocks: [InfoBlock]
}

struct InfoBlock: Hashable {
    var blockTitle: String
    var blockBullets: [String]
}

let mealPrepGuide = ArticleInformation(
    title: "How to use the meal prep guide",
    subTitle: "Written by Rita Stegman, Registered Dietitian",
    articleBlocks:[
        InfoBlock(blockTitle: "Steps", blockBullets:
                    ["Make note of all the food in your fridge, freezer and pantry", "Create a few meals using the element you have on your list",
                     "Fill out the calendar to make sure you have enough meals for the week"
                    ]),
        InfoBlock(blockTitle: "Tips", blockBullets:
                    ["Start with food in your fridge, then the freezer and then use things from you pantry", "Reduce food waste by using FIFO (First In, First Out)", "Get creative with condiments (Wine, yogurt, canned tomato, etc)"
                    ])
    ]
)

let makeAMealGuide = ArticleInformation(
    title: "What makes a meal?",
    subTitle: "Written by Rita Stegman, Registered Dietitian",
    articleBlocks:[
        InfoBlock(blockTitle: "Fruits & Vegetables", blockBullets:
                    ["Experts recommend at least 2 1/2 cups of vegetables each day", "Get creative and have a mix of raw and cooked vegetables",
                     "When in doubt, roasting is a great way to bring out flavor", "Tip: frozen vegetables are an excellent option to save time and money!"
                    ]),
        InfoBlock(blockTitle: "Protein", blockBullets:
                    ["All meals should have a starchy base to provide energy, volume and vitamins", "Examples of starch are:\n  - Grains (rice, quinoa, farro)\n  - Starchy vegetables (corn and potatoes)\n  - Bread, pasta, etc"
                    ]),
        InfoBlock(blockTitle: "Starch", blockBullets:
                    ["All meals should have protein for satiety, energy stability and overall health benefits", "Mixing in vegetarian proteins to lower your intake of saturated fats", "Processed proteins (sausage and fake meat) can be time savers but spread them out to reduce your intake of salt"
                    ]),
        InfoBlock(blockTitle: "Condiments", blockBullets:
                    ["Depending on your sill (and time), you can use the things in your home to create different sauces, marinades and seasonings", "This is essential for using up random ingredients and also adding variety... and excitement!"
                    ])
    ]
)

let wellBalancedMeal = ArticleInformation(
    title: "Create a well-balanced meal",
    subTitle: "Myplate | US Department of agriculture",
    articleBlocks:[]
)
