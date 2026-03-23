//
//  CompareViewModel.swift
//  TypeFace
//
//  ViewModel for font comparison functionality
//

import Foundation
import SwiftUI

@Observable
final class CompareViewModel {
    var selectedFonts: [FontInfo?] = [nil, nil, nil, nil]
    var comparisonText: String = "The quick brown fox jumps over the lazy dog"
    var typographySettings: TypographySettings = .default
    var numberOfPanels: Int = 2

    func selectFont(_ font: FontInfo, at index: Int) {
        guard index >= 0 && index < selectedFonts.count else { return }
        selectedFonts[index] = font
        HapticManager.shared.selectionChanged()
    }

    func removeFont(at index: Int) {
        guard index >= 0 && index < selectedFonts.count else { return }
        selectedFonts[index] = nil
        HapticManager.shared.impact(.light)
    }

    func swapFonts(from source: Int, to destination: Int) {
        guard source >= 0 && source < selectedFonts.count &&
              destination >= 0 && destination < selectedFonts.count else { return }
        selectedFonts.swapAt(source, destination)
        HapticManager.shared.impact(.medium)
    }

    func setNumberOfPanels(_ count: Int) {
        numberOfPanels = min(max(count, 2), 4)
        HapticManager.shared.selectionChanged()
    }

    func clearAll() {
        selectedFonts = [nil, nil, nil, nil]
        HapticManager.shared.impact(.light)
    }

    func resetSettings() {
        typographySettings = .default
        HapticManager.shared.impact(.light)
    }

    var activeFonts: [FontInfo] {
        selectedFonts.prefix(numberOfPanels).compactMap { $0 }
    }
}
