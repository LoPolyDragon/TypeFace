//
//  CollectionDetailView.swift
//  TypeFace
//
//  Detail view for a font collection
//

import SwiftUI
import SwiftData

struct CollectionDetailView: View {
    let collection: FontCollection

    @Environment(\.modelContext) private var modelContext
    @State private var isEditing = false
    @State private var editedName: String = ""
    @State private var editedNotes: String = ""
    @State private var showingFontPicker = false
    @State private var previewText = "The quick brown fox"

    private let fontService = FontService.shared

    var fonts: [FontInfo] {
        collection.fontNames.compactMap { fontService.getFontInfo(fontName: $0) }
    }

    var body: some View {
        List {
            Section {
                if isEditing {
                    TextField("Collection Name", text: $editedName)
                    TextField("Notes", text: $editedNotes, axis: .vertical)
                        .lineLimit(3...6)
                } else {
                    if !collection.notes.isEmpty {
                        Text(collection.notes)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    HStack {
                        Text("Created")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(collection.dateCreated.formatted(date: .abbreviated, time: .omitted))
                    }
                    .font(.caption)

                    HStack {
                        Text("Modified")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(collection.dateModified.formatted(date: .abbreviated, time: .omitted))
                    }
                    .font(.caption)
                }
            }

            Section {
                ForEach(fonts) { font in
                    NavigationLink {
                        FontDetailView(font: font)
                    } label: {
                        FontPreviewRow(
                            font: font,
                            previewText: previewText,
                            fontSize: 18
                        )
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        collection.fontNames.remove(at: index)
                    }
                    collection.updateModifiedDate()
                    try? modelContext.save()
                }

                if isEditing {
                    Button {
                        showingFontPicker = true
                    } label: {
                        Label("Add Font", systemImage: "plus.circle.fill")
                    }
                }
            } header: {
                Text("Fonts (\(fonts.count))")
            }
        }
        .navigationTitle(isEditing ? "Edit Collection" : collection.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(isEditing ? "Done" : "Edit") {
                    if isEditing {
                        collection.name = editedName
                        collection.notes = editedNotes
                        collection.updateModifiedDate()
                        try? modelContext.save()
                        HapticManager.shared.notification(.success)
                    } else {
                        editedName = collection.name
                        editedNotes = collection.notes
                    }
                    isEditing.toggle()
                }
            }
        }
        .sheet(isPresented: $showingFontPicker) {
            FontPicker(selectedFont: Binding(
                get: { nil },
                set: { newFont in
                    if let font = newFont, !collection.fontNames.contains(font.fontName) {
                        collection.fontNames.append(font.fontName)
                        collection.updateModifiedDate()
                        try? modelContext.save()
                        HapticManager.shared.notification(.success)
                    }
                }
            ))
        }
        .onAppear {
            editedName = collection.name
            editedNotes = collection.notes
        }
    }
}

#Preview {
    NavigationStack {
        CollectionDetailView(
            collection: FontCollection(
                name: "My Collection",
                fontNames: ["SFProText-Regular", "Georgia"],
                notes: "Great font combination"
            )
        )
        .modelContainer(for: [FavoriteFont.self, FontCollection.self])
    }
}
