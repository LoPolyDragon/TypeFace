//
//  TypographyControls.swift
//  TypeFace
//
//  Reusable component for typography customization controls
//

import SwiftUI

struct TypographyControls: View {
    @Binding var settings: TypographySettings
    var showColorPicker: Bool = true
    var showAlignment: Bool = true

    var body: some View {
        VStack(spacing: 20) {
            // Font Size
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Label("Size", systemImage: "textformat.size")
                        .font(.subheadline.weight(.medium))
                    Spacer()
                    Text("\(Int(settings.fontSize))pt")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Slider(value: $settings.fontSize, in: 8...120, step: 1)
                    .tint(.accentColor)
            }

            // Letter Spacing
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Label("Letter Spacing", systemImage: "arrow.left.and.right")
                        .font(.subheadline.weight(.medium))
                    Spacer()
                    Text(String(format: "%.1f", settings.letterSpacing))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Slider(value: $settings.letterSpacing, in: -5...10, step: 0.1)
                    .tint(.accentColor)
            }

            // Line Height
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Label("Line Height", systemImage: "arrow.up.and.down")
                        .font(.subheadline.weight(.medium))
                    Spacer()
                    Text(String(format: "%.2f", settings.lineHeight))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Slider(value: $settings.lineHeight, in: 0.8...2.5, step: 0.05)
                    .tint(.accentColor)
            }

            if showColorPicker {
                // Color Picker
                VStack(alignment: .leading, spacing: 8) {
                    Label("Color", systemImage: "paintpalette")
                        .font(.subheadline.weight(.medium))

                    ColorPicker("Text Color", selection: Binding(
                        get: { settings.textColor.color },
                        set: { settings.textColor = CodableColor(color: $0) }
                    ))
                    .labelsHidden()
                }
            }

            if showAlignment {
                // Text Alignment
                VStack(alignment: .leading, spacing: 8) {
                    Label("Alignment", systemImage: "text.alignleft")
                        .font(.subheadline.weight(.medium))

                    HStack(spacing: 12) {
                        ForEach(TextAlignmentOption.allCases, id: \.self) { option in
                            Button {
                                settings.alignment = option
                                HapticManager.shared.selectionChanged()
                            } label: {
                                Image(systemName: option.icon)
                                    .font(.title3)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(
                                        settings.alignment == option
                                        ? Color.accentColor.opacity(0.2)
                                        : Color.cardBackground
                                    )
                                    .foregroundStyle(
                                        settings.alignment == option
                                        ? Color.accentColor
                                        : Color.primary
                                    )
                                    .cornerRadius(8)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.cardBackground)
        .cornerRadius(12)
    }
}

#Preview {
    TypographyControls(settings: .constant(.default))
        .padding()
}
