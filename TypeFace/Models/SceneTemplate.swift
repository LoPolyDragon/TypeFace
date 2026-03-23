//
//  SceneTemplate.swift
//  TypeFace
//
//  Model for scene template mockups
//

import SwiftUI

enum SceneTemplate: String, CaseIterable, Identifiable {
    case titleHeading = "Title/Heading"
    case bodyText = "Body Text"
    case logo = "Logo"
    case poster = "Poster"
    case socialMedia = "Social Media Post"
    case businessCard = "Business Card"
    case appUI = "App UI"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .titleHeading: return "textformat.size"
        case .bodyText: return "doc.text"
        case .logo: return "circle.hexagongrid.fill"
        case .poster: return "rectangle.portrait"
        case .socialMedia: return "rectangle.inset.filled"
        case .businessCard: return "creditcard"
        case .appUI: return "app.fill"
        }
    }

    var description: String {
        switch self {
        case .titleHeading: return "Preview as a title or heading"
        case .bodyText: return "See how it looks in paragraph form"
        case .logo: return "Test as a logo or brand wordmark"
        case .poster: return "View in poster layout"
        case .socialMedia: return "Preview in social media format"
        case .businessCard: return "See on a business card design"
        case .appUI: return "Preview in app interface"
        }
    }

    var defaultText: String {
        switch self {
        case .titleHeading:
            return "The Quick Brown Fox"
        case .bodyText:
            return "The quick brown fox jumps over the lazy dog. Pack my box with five dozen liquor jugs. How vexingly quick daft zebras jump!"
        case .logo:
            return "TypeFace"
        case .poster:
            return "DESIGN\nFESTIVAL\n2026"
        case .socialMedia:
            return "Typography\nMatters"
        case .businessCard:
            return "John Smith\nCreative Director"
        case .appUI:
            return "Welcome Back"
        }
    }

    var suggestedFontSize: CGFloat {
        switch self {
        case .titleHeading: return 48
        case .bodyText: return 16
        case .logo: return 64
        case .poster: return 72
        case .socialMedia: return 56
        case .businessCard: return 20
        case .appUI: return 32
        }
    }

    var aspectRatio: CGFloat? {
        switch self {
        case .socialMedia: return 1.0
        case .businessCard: return 1.75
        case .poster: return 0.7
        default: return nil
        }
    }
}
