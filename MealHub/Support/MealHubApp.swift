//
//  MealHubApp.swift
//  MealHub
//
//  Created by Derek Howes on 6/6/23.
//

import SwiftUI

@main
struct MealHubApp: App {
    @Environment(\.scenePhase) var scenePhase
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavView()
                .environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.saveData()
        }
    }
}
