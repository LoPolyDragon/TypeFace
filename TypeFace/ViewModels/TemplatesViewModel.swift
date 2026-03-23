//
//  TemplatesViewModel.swift
//  TypeFace
//
//  ViewModel for template scene functionality
//

import Foundation
import SwiftUI

@Observable
final class TemplatesViewModel {
    var selectedTemplate: SceneTemplate = .titleHeading
    var selectedFont: FontInfo?
    var customText: String = ""
    var typographySettings: TypographySettings

    init() {
        self.typographySettings = TypographySettings(
            fontSize: SceneTemplate.titleHeading.suggestedFontSize
        )
        self.customText = SceneTemplate.titleHeading.defaultText
    }

    var displayText: String {
        customText.isEmpty ? selectedTemplate.defaultText : customText
    }

    func selectTemplate(_ template: SceneTemplate) {
        selectedTemplate = template
        typographySettings.fontSize = template.suggestedFontSize
        if customText.isEmpty {
            customText = template.defaultText
        }
        HapticManager.shared.selectionChanged()
    }

    func selectFont(_ font: FontInfo) {
        selectedFont = font
        HapticManager.shared.selectionChanged()
    }

    func resetToDefaults() {
        customText = selectedTemplate.defaultText
        typographySettings.fontSize = selectedTemplate.suggestedFontSize
        HapticManager.shared.impact(.light)
    }
}
