//
//  FontDetailView.swift
//  TypeFace
//
//  Detailed view for a single font with metadata
//

import SwiftUI
import SwiftData

struct FontDetailView: View {
    let font: FontInfo
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = FavoritesViewModel()
    @State private var previewText = "The quick brown fox jumps over the lazy dog. 0123456789"
    @State private var fontSize: CGFloat = 24

    private let fontService = FontService.shared

    var isFavorite: Bool {
        viewModel.isFavorite(fontName: font.fontName, context: modelContext)
    }

    var metadata: FontMetadata? {
        fontService.getFontMetadata(fontName: font.fontName)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Preview Section
                VStack(spacing: 16) {
                    Text(previewText)
                        .font(.custom(font.fontName, size: fontSize))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.cardBackground)
                        .cornerRadius(12)

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Size")
                                .font(.subheadline.weight(.medium))
                            Spacer()
                            Text("\(Int(fontSize))pt")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Slider(value: $fontSize, in: 12...72, step: 1)
                    }
                    .padding()
                    .background(Color.cardBackground)
                    .cornerRadius(12)
                }

                // Metadata Section
                if let metadata = metadata {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Font Information")
                            .font(.headline)

                        MetadataRow(label: "Family", value: metadata.familyName)
                        MetadataRow(label: "Style", value: metadata.styleName)
                        MetadataRow(label: "PostScript Name", value: metadata.fontName)
                        MetadataRow(label: "Weight", value: String(format: "%.2f", metadata.weight))
                        MetadataRow(label: "Slant", value: String(format: "%.2f", metadata.slant))
                        MetadataRow(label: "Monospaced", value: metadata.isMonospaced ? "Yes" : "No")
                    }
                    .padding()
                    .background(Color.cardBackground)
                    .cornerRadius(12)

                    // Character Set Preview
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Character Set Preview")
                            .font(.headline)

                        Text(metadata.characterSet)
                            .font(.custom(font.fontName, size: 18))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    .background(Color.cardBackground)
                    .cornerRadius(12)
                }

                // All Glyphs Preview
                VStack(alignment: .leading, spacing: 12) {
                    Text("Alphabet & Numbers")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                            .font(.custom(font.fontName, size: 20))
                        Text("abcdefghijklmnopqrstuvwxyz")
                            .font(.custom(font.fontName, size: 20))
                        Text("0123456789")
                            .font(.custom(font.fontName, size: 20))
                        Text("!@#$%^&*()[]{}.,;:?'\"-_+=/<>")
                            .font(.custom(font.fontName, size: 20))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .background(Color.cardBackground)
                .cornerRadius(12)
            }
            .padding()
        }
        .navigationTitle(font.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    viewModel.toggleFavorite(font: font, context: modelContext)
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(isFavorite ? .red : .primary)
                }
            }
        }
    }
}

struct MetadataRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
        .font(.subheadline)
    }
}

#Preview {
    NavigationStack {
        FontDetailView(font: FontInfo(familyName: "San Francisco", fontName: "SFProText-Regular"))
            .modelContainer(for: [FavoriteFont.self, FontCollection.self])
    }
}
