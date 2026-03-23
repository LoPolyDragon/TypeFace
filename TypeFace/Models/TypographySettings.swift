//
//  TypographySettings.swift
//  TypeFace
//
//  Model for typography customization settings
//

import SwiftUI

struct TypographySettings: Codable {
    var fontSize: CGFloat
    var letterSpacing: CGFloat
    var lineHeight: CGFloat
    var textColor: CodableColor
    var alignment: TextAlignmentOption

    init(
        fontSize: CGFloat = 24,
        letterSpacing: CGFloat = 0,
        lineHeight: CGFloat = 1.2,
        textColor: CodableColor = CodableColor(color: .primary),
        alignment: TextAlignmentOption = .leading
    ) {
        self.fontSize = fontSize
        self.letterSpacing = letterSpacing
        self.lineHeight = lineHeight
        self.textColor = textColor
        self.alignment = alignment
    }

    static let `default` = TypographySettings()
}

enum TextAlignmentOption: String, Codable, CaseIterable {
    case leading = "Left"
    case center = "Center"
    case trailing = "Right"

    var textAlignment: TextAlignment {
        switch self {
        case .leading: return .leading
        case .center: return .center
        case .trailing: return .trailing
        }
    }

    var icon: String {
        switch self {
        case .leading: return "text.alignleft"
        case .center: return "text.aligncenter"
        case .trailing: return "text.alignright"
        }
    }
}

/// Codable wrapper for Color to support persistence
struct CodableColor: Codable, Equatable {
    var red: Double
    var green: Double
    var blue: Double
    var opacity: Double

    init(color: Color) {
        // Extract components using UIColor
        let uiColor = UIColor(color)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)

        self.red = Double(r)
        self.green = Double(g)
        self.blue = Double(b)
        self.opacity = Double(a)
    }

    var color: Color {
        Color(red: red, green: green, blue: blue, opacity: opacity)
    }
}
