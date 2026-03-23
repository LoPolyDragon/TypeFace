//
//  FavoritesView.swift
//  TypeFace
//
//  Main view for managing favorite fonts and collections
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @State private var viewModel = FavoritesViewModel()
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \FavoriteFont.dateAdded, order: .reverse)
    private var favoriteFonts: [FavoriteFont]

    @Query(sort: \FontCollection.dateModified, order: .reverse)
    private var collections: [FontCollection]

    private let fontService = FontService.shared

    var filteredFonts: [FavoriteFont] {
        if viewModel.searchQuery.isEmpty {
            return favoriteFonts
        }
        return favoriteFonts.filter {
            $0.fontName.localizedCaseInsensitiveContains(viewModel.searchQuery) ||
            $0.familyName.localizedCaseInsensitiveContains(viewModel.searchQuery)
        }
    }

    var filteredCollections: [FontCollection] {
        if viewModel.searchQuery.isEmpty {
            return collections
        }
        return collections.filter {
            $0.name.localizedCaseInsensitiveContains(viewModel.searchQuery)
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Tab Selector
                Picker("Type", selection: $viewModel.selectedTab) {
                    ForEach(FavoritesViewModel.FavoritesTab.allCases, id: \.self) { tab in
                        Label(tab.rawValue, systemImage: tab.icon)
                            .tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                // Content
                if viewModel.selectedTab == .fonts {
                    FavoriteFontsListView(
                        fonts: filteredFonts,
                        onDelete: { font in
                            viewModel.removeFavorite(fontName: font.fontName, context: modelContext)
                        }
                    )
                } else {
                    CollectionsListView(
                        collections: filteredCollections,
                        onDelete: { collection in
                            viewModel.deleteCollection(collection, context: modelContext)
                        }
                    )
                }
            }
            .navigationTitle("Favorites")
            .searchable(text: $viewModel.searchQuery, prompt: "Search")
            .toolbar {
                if viewModel.selectedTab == .collections {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            viewModel.showingAddCollection = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingAddCollection) {
                CreateCollectionView()
            }
        }
    }
}

#Preview {
    FavoritesView()
        .modelContainer(for: [FavoriteFont.self, FontCollection.self])
}
