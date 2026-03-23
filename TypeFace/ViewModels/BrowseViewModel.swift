//
//  BrowseViewModel.swift
//  TypeFace
//
//  ViewModel for font browsing functionality
//

import Foundation
import SwiftUI

@Observable
final class BrowseViewModel {
    var searchQuery: String = ""
    var selectedFont: FontInfo?
    var previewText: String = "The quick brown fox jumps over the lazy dog"
    var typographySettings: TypographySettings = .default

    private let fontService = FontService.shared

    var filteredFamilies: [FontFamily] {
        if searchQuery.isEmpty {
            return fontService.allFontFamilies
        }
        return fontService.searchFonts(query: searchQuery)
    }

    func selectFont(_ font: FontInfo) {
        selectedFont = font
        HapticManager.shared.selectionChanged()
    }

    func clearSelection() {
        selectedFont = nil
    }

    func resetSettings() {
        typographySettings = .default
        HapticManager.shared.impact(.light)
    }
}
