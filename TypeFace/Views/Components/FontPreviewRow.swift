//
//  FontPreviewRow.swift
//  TypeFace
//
//  Reusable component for displaying a font in a list
//

import SwiftUI

struct FontPreviewRow: View {
    let font: FontInfo
    let previewText: String
    let fontSize: CGFloat
    let showMetadata: Bool

    init(
        font: FontInfo,
        previewText: String = "The quick brown fox",
        fontSize: CGFloat = 20,
        showMetadata: Bool = true
    ) {
        self.font = font
        self.previewText = previewText
        self.fontSize = fontSize
        self.showMetadata = showMetadata
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if showMetadata {
                HStack {
                    Text(font.fontName)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Spacer()

                    HStack(spacing: 4) {
                        if font.isItalic {
                            Image(systemName: "italic")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                        Text(font.weight)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
            }

            Text(previewText)
                .font(.custom(font.fontName, size: fontSize))
                .lineLimit(2)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    List {
        FontPreviewRow(
            font: FontInfo(familyName: "San Francisco", fontName: "SFProText-Regular"),
            previewText: "The quick brown fox jumps over the lazy dog"
        )
    }
}
