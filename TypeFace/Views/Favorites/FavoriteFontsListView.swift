//
//  FavoriteFontsListView.swift
//  TypeFace
//
//  List view for favorite fonts
//

import SwiftUI

struct FavoriteFontsListView: View {
    let fonts: [FavoriteFont]
    let onDelete: (FavoriteFont) -> Void

    private let fontService = FontService.shared

    var body: some View {
        if fonts.isEmpty {
            EmptyStateView(
                icon: "heart.slash",
                title: "No Favorite Fonts",
                message: "Fonts you favorite will appear here"
            )
        } else {
            List {
                ForEach(fonts, id: \.id) { favoriteFont in
                    if let fontInfo = fontService.getFontInfo(fontName: favoriteFont.fontName) {
                        NavigationLink {
                            FontDetailView(font: fontInfo)
                        } label: {
                            FontPreviewRow(
                                font: fontInfo,
                                previewText: "The quick brown fox jumps over the lazy dog",
                                fontSize: 18
                            )
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                onDelete(favoriteFont)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .contextMenu {
                            Button {
                                onDelete(favoriteFont)
                            } label: {
                                Label("Remove from Favorites", systemImage: "heart.slash")
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    FavoriteFontsListView(
        fonts: [],
        onDelete: { _ in }
    )
}
