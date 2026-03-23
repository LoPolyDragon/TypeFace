//
//  FontService.swift
//  TypeFace
//
//  Service for font enumeration, metadata, and CoreText integration
//

import Foundation
import UIKit
import CoreText

@Observable
final class FontService {
    static let shared = FontService()

    private(set) var allFontFamilies: [FontFamily] = []
    private(set) var allFonts: [FontInfo] = []
    private var fontCache: [String: UIFont] = [:]

    private init() {
        loadFonts()
    }

    func loadFonts() {
        let familyNames = UIFont.familyNames.sorted()
        var families: [FontFamily] = []
        var fonts: [FontInfo] = []

        for familyName in familyNames {
            let fontNames = UIFont.fontNames(forFamilyName: familyName).sorted()
            let fontInfos = fontNames.map { FontInfo(familyName: familyName, fontName: $0) }

            if !fontInfos.isEmpty {
                families.append(FontFamily(name: familyName, fonts: fontInfos))
                fonts.append(contentsOf: fontInfos)
            }
        }

        self.allFontFamilies = families
        self.allFonts = fonts
    }

    func getUIFont(name: String, size: CGFloat) -> UIFont {
        let cacheKey = "\(name)-\(size)"
        if let cachedFont = fontCache[cacheKey] {
            return cachedFont
        }

        let font = UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
        fontCache[cacheKey] = font
        return font
    }

    func getFontMetadata(fontName: String) -> FontMetadata? {
        guard let font = UIFont(name: fontName, size: 12) else { return nil }

        let fontRef = CTFontCreateWithName(fontName as CFString, 12, nil)
        let traits = CTFontCopyTraits(fontRef) as NSDictionary

        return FontMetadata(
            fontName: fontName,
            displayName: CTFontCopyDisplayName(fontRef) as String? ?? fontName,
            familyName: CTFontCopyFamilyName(fontRef) as String? ?? "",
            styleName: CTFontCopyName(fontRef, kCTFontStyleNameKey) as String? ?? "",
            weight: traits[kCTFontWeightTrait] as? CGFloat ?? 0,
            slant: traits[kCTFontSlantTrait] as? CGFloat ?? 0,
            isMonospaced: (traits[kCTFontSymbolicTrait] as? UInt32 ?? 0) & CTFontSymbolicTraits.traitMonoSpace.rawValue != 0,
            characterSet: getCharacterSet(for: fontRef)
        )
    }

    private func getCharacterSet(for font: CTFont) -> String {
        let characterSet = CTFontCopyCharacterSet(font)
        var characters = ""

        // Sample common characters to show what the font supports
        let sampleChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()[]{}.,;:?'\"-_+=/<>"

        for char in sampleChars {
            let unicodeScalar = char.unicodeScalars.first!
            if CFCharacterSetIsCharacterMember(characterSet, unicodeScalar.value) {
                characters.append(char)
            }
        }

        return characters
    }

    func searchFonts(query: String) -> [FontFamily] {
        guard !query.isEmpty else { return allFontFamilies }

        let lowercaseQuery = query.lowercased()
        return allFontFamilies.filter { family in
            family.name.lowercased().contains(lowercaseQuery) ||
            family.fonts.contains { $0.fontName.lowercased().contains(lowercaseQuery) }
        }
    }

    func getFontFamily(name: String) -> FontFamily? {
        allFontFamilies.first { $0.name == name }
    }

    func getFontInfo(fontName: String) -> FontInfo? {
        allFonts.first { $0.fontName == fontName }
    }
}

struct FontMetadata {
    let fontName: String
    let displayName: String
    let familyName: String
    let styleName: String
    let weight: CGFloat
    let slant: CGFloat
    let isMonospaced: Bool
    let characterSet: String
}
