//
//  FontCollection.swift
//  TypeFace
//
//  SwiftData model for persisting font collections (combinations)
//

import Foundation
import SwiftData

@Model
final class FontCollection {
    var id: UUID
    var name: String
    var fontNames: [String]
    var dateCreated: Date
    var dateModified: Date
    var notes: String

    init(name: String, fontNames: [String], notes: String = "") {
        self.id = UUID()
        self.name = name
        self.fontNames = fontNames
        self.dateCreated = Date()
        self.dateModified = Date()
        self.notes = notes
    }

    func updateModifiedDate() {
        self.dateModified = Date()
    }
}
