//
//  FontPreviewPanel.swift
//  TypeFace
//
//  Expandable preview panel for selected font
//

import SwiftUI

struct FontPreviewPanel: View {
    let font: FontInfo?
    @Binding var previewText: String
    @Binding var settings: TypographySettings
    let onClose: () -> Void

    @State private var isExpanded = false

    var body: some View {
        VStack(spacing: 0) {
            if let font = font {
                VStack(spacing: 12) {
                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(font.displayName)
                                .font(.headline)
                            Text(font.familyName)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        Button {
                            withAnimation {
                                isExpanded.toggle()
                            }
                            HapticManager.shared.impact(.light)
                        } label: {
                            Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                .foregroundStyle(.secondary)
                        }

                        Button {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                onClose()
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.secondary)
                        }
                    }

                    // Preview Text
                    Text(previewText)
                        .applyTypographySettings(settings, fontName: font.fontName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(uiColor: .systemBackground))
                        .cornerRadius(8)
                        .frame(height: isExpanded ? 200 : 100)

                    if isExpanded {
                        // Typography Controls
                        TypographyControls(settings: $settings)
                            .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
                .padding()
                .background(Color.cardBackground)
                .shadow(color: Color.black.opacity(0.1), radius: 10, y: 5)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isExpanded)
    }
}

#Preview {
    FontPreviewPanel(
        font: FontInfo(familyName: "San Francisco", fontName: "SFProText-Regular"),
        previewText: .constant("The quick brown fox"),
        settings: .constant(.default),
        onClose: {}
    )
}
