//
//  FontInfo.swift
//  TypeFace
//
//  Core font information model for representing iOS system fonts
//

import Foundation
import SwiftUI
import UIKit

/// Represents a single font with all its metadata
struct FontInfo: Identifiable, Hashable, Codable {
    let id: UUID
    let familyName: String
    let fontName: String
    let displayName: String
    let weight: String
    let isItalic: Bool

    init(familyName: String, fontName: String) {
        self.id = UUID()
        self.familyName = familyName
        self.fontName = fontName

        // Extract display name from font name
        if fontName.contains("-") {
            let components = fontName.split(separator: "-")
            self.displayName = String(components.last ?? "")
        } else {
            self.displayName = fontName
        }

        // Determine weight and italic status from font name
        let lowercaseName = fontName.lowercased()
        self.isItalic = lowercaseName.contains("italic") || lowercaseName.contains("oblique")

        if lowercaseName.contains("ultralight") || lowercaseName.contains("thin") {
            self.weight = "Ultralight"
        } else if lowercaseName.contains("light") {
            self.weight = "Light"
        } else if lowercaseName.contains("medium") {
            self.weight = "Medium"
        } else if lowercaseName.contains("semibold") || lowercaseName.contains("demibold") {
            self.weight = "Semibold"
        } else if lowercaseName.contains("bold") {
            self.weight = "Bold"
        } else if lowercaseName.contains("heavy") || lowercaseName.contains("black") {
            self.weight = "Heavy"
        } else {
            self.weight = "Regular"
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(fontName)
    }

    static func == (lhs: FontInfo, rhs: FontInfo) -> Bool {
        lhs.fontName == rhs.fontName
    }
}

/// Represents a font family with all its variants
struct FontFamily: Identifiable, Hashable {
    let id: UUID
    let name: String
    let fonts: [FontInfo]

    init(name: String, fonts: [FontInfo]) {
        self.id = UUID()
        self.name = name
        self.fonts = fonts.sorted { lhs, rhs in
            // Sort by weight first, then by italic
            if lhs.weight != rhs.weight {
                let weightOrder = ["Ultralight", "Light", "Regular", "Medium", "Semibold", "Bold", "Heavy"]
                let lhsIndex = weightOrder.firstIndex(of: lhs.weight) ?? 2
                let rhsIndex = weightOrder.firstIndex(of: rhs.weight) ?? 2
                return lhsIndex < rhsIndex
            }
            return !lhs.isItalic && rhs.isItalic
        }
    }

    var previewFont: FontInfo {
        fonts.first(where: { $0.weight == "Regular" && !$0.isItalic }) ?? fonts.first!
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    static func == (lhs: FontFamily, rhs: FontFamily) -> Bool {
        lhs.name == rhs.name
    }
}
