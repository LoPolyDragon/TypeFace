//
//  FavoritesViewModel.swift
//  TypeFace
//
//  ViewModel for favorites and collections management
//

import Foundation
import SwiftUI
import SwiftData

@Observable
final class FavoritesViewModel {
    var searchQuery: String = ""
    var selectedTab: FavoritesTab = .fonts
    var showingAddCollection: Bool = false

    enum FavoritesTab: String, CaseIterable {
        case fonts = "Fonts"
        case collections = "Collections"

        var icon: String {
            switch self {
            case .fonts: return "textformat"
            case .collections: return "square.grid.2x2"
            }
        }
    }

    func isFavorite(fontName: String, context: ModelContext) -> Bool {
        let descriptor = FetchDescriptor<FavoriteFont>(
            predicate: #Predicate { $0.fontName == fontName }
        )
        let count = (try? context.fetchCount(descriptor)) ?? 0
        return count > 0
    }

    func toggleFavorite(font: FontInfo, context: ModelContext) {
        if isFavorite(fontName: font.fontName, context: context) {
            removeFavorite(fontName: font.fontName, context: context)
        } else {
            addFavorite(font: font, context: context)
        }
    }

    func addFavorite(font: FontInfo, context: ModelContext) {
        let favorite = FavoriteFont(
            fontName: font.fontName,
            familyName: font.familyName
        )
        context.insert(favorite)
        try? context.save()
        HapticManager.shared.notification(.success)
    }

    func removeFavorite(fontName: String, context: ModelContext) {
        let descriptor = FetchDescriptor<FavoriteFont>(
            predicate: #Predicate { $0.fontName == fontName }
        )
        if let favorites = try? context.fetch(descriptor) {
            favorites.forEach { context.delete($0) }
            try? context.save()
            HapticManager.shared.impact(.light)
        }
    }

    func createCollection(name: String, fonts: [FontInfo], context: ModelContext) {
        let collection = FontCollection(
            name: name,
            fontNames: fonts.map { $0.fontName }
        )
        context.insert(collection)
        try? context.save()
        HapticManager.shared.notification(.success)
    }

    func deleteCollection(_ collection: FontCollection, context: ModelContext) {
        context.delete(collection)
        try? context.save()
        HapticManager.shared.impact(.light)
    }

    func updateCollection(_ collection: FontCollection, context: ModelContext) {
        collection.updateModifiedDate()
        try? context.save()
        HapticManager.shared.impact(.light)
    }
}
