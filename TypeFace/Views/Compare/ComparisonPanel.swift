//
//  ComparisonPanel.swift
//  TypeFace
//
//  Individual panel for font comparison
//

import SwiftUI

struct ComparisonPanel: View {
    let font: FontInfo?
    let text: String
    let settings: TypographySettings
    let onSelectFont: () -> Void
    let onRemoveFont: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                if let font = font {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(font.displayName)
                            .font(.subheadline.weight(.semibold))
                            .lineLimit(1)
                        Text(font.familyName)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }

                    Spacer()

                    Button {
                        onRemoveFont()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                } else {
                    Text("No Font Selected")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Spacer()
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, 12)

            // Preview Area
            if let font = font {
                ScrollView {
                    Text(text)
                        .applyTypographySettings(settings, fontName: font.fontName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(12)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Button {
                    onSelectFont()
                } label: {
                    VStack(spacing: 12) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(.secondary)
                        Text("Choose Font")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .background(Color.cardBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.accentColor.opacity(font == nil ? 0 : 0.2), lineWidth: 1)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            if font != nil {
                onSelectFont()
            }
        }
    }
}

#Preview {
    VStack {
        ComparisonPanel(
            font: FontInfo(familyName: "San Francisco", fontName: "SFProText-Regular"),
            text: "The quick brown fox",
            settings: .default,
            onSelectFont: {},
            onRemoveFont: {}
        )
        .frame(height: 200)

        ComparisonPanel(
            font: nil,
            text: "The quick brown fox",
            settings: .default,
            onSelectFont: {},
            onRemoveFont: {}
        )
        .frame(height: 200)
    }
    .padding()
}
