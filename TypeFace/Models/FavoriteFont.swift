//
//  FavoriteFont.swift
//  TypeFace
//
//  SwiftData model for persisting favorite fonts
//

import Foundation
import SwiftData

@Model
final class FavoriteFont {
    var id: UUID
    var fontName: String
    var familyName: String
    var dateAdded: Date
    var notes: String

    init(fontName: String, familyName: String, notes: String = "") {
        self.id = UUID()
        self.fontName = fontName
        self.familyName = familyName
        self.dateAdded = Date()
        self.notes = notes
    }
}
