//
//  HackerNewsNewApp.swift
//  HackerNewsNew
//
//  Created by ran you on 2/16/22.
//

import SwiftUI

@main
struct HackerNewsNewApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
