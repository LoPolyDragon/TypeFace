//
//  TypeFaceApp.swift
//  TypeFace
//
//  Main app entry point
//

import SwiftUI
import SwiftData

@main
struct TypeFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [FavoriteFont.self, FontCollection.self])
        }
    }
}
