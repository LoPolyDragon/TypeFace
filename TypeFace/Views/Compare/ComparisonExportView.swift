//
//  ComparisonExportView.swift
//  TypeFace
//
//  Renderable view for exporting font comparisons
//

import SwiftUI

struct ComparisonExportView: View {
    let fonts: [FontInfo]
    let text: String
    let settings: TypographySettings

    var body: some View {
        VStack(spacing: 24) {
            ForEach(fonts, id: \.id) { font in
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(font.displayName)
                            .font(.caption.weight(.semibold))
                        Spacer()
                        Text(font.familyName)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }

                    Text(text)
                        .applyTypographySettings(settings, fontName: font.fontName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            }
        }
        .padding(24)
        .background(Color(white: 0.95))
    }
}

#Preview {
    ComparisonExportView(
        fonts: [
            FontInfo(familyName: "San Francisco", fontName: "SFProText-Regular"),
            FontInfo(familyName: "Georgia", fontName: "Georgia")
        ],
        text: "The quick brown fox",
        settings: .default
    )
}
