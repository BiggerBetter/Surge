//
//  SurgeApp.swift
//  Surge
//
//  Created by Jiong on 2025/3/1.
//

import SwiftUI
import SwiftData

@main
struct SurgeApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])

            if let url = container.configurations.first?.url {
                print("SwiftData 数据存储位置为: \(url)")
            }

            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
