//
//  ContentView.swift
//  TypeFace
//
//  Root view with tab navigation
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .browse

    enum Tab {
        case browse
        case compare
        case templates
        case favorites
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "textformat")
                }
                .tag(Tab.browse)

            CompareView()
                .tabItem {
                    Label("Compare", systemImage: "square.split.2x1")
                }
                .tag(Tab.compare)

            TemplatesView()
                .tabItem {
                    Label("Templates", systemImage: "rectangle.on.rectangle")
                }
                .tag(Tab.templates)

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
                .tag(Tab.favorites)
        }
        .tint(.accentColor)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [FavoriteFont.self, FontCollection.self])
}
