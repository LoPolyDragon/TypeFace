//
//  FontPicker.swift
//  TypeFace
//
//  Reusable font picker component
//

import SwiftUI

struct FontPicker: View {
    @Binding var selectedFont: FontInfo?
    @Environment(\.dismiss) private var dismiss

    @State private var searchQuery = ""
    private let fontService = FontService.shared

    var filteredFamilies: [FontFamily] {
        if searchQuery.isEmpty {
            return fontService.allFontFamilies
        }
        return fontService.searchFonts(query: searchQuery)
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredFamilies) { family in
                    Section {
                        ForEach(family.fonts) { font in
                            Button {
                                selectedFont = font
                                HapticManager.shared.selectionChanged()
                                dismiss()
                            } label: {
                                FontPreviewRow(font: font, fontSize: 18)
                            }
                            .buttonStyle(.plain)
                        }
                    } header: {
                        Text(family.name)
                    }
                }
            }
            .searchable(text: $searchQuery, prompt: "Search fonts")
            .navigationTitle("Choose Font")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    FontPicker(selectedFont: .constant(nil))
}
