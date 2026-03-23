//
//  CreateCollectionView.swift
//  TypeFace
//
//  Sheet for creating a new font collection
//

import SwiftUI
import SwiftData

struct CreateCollectionView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var name = ""
    @State private var notes = ""
    @State private var selectedFonts: [FontInfo] = []
    @State private var showingFontPicker = false

    private let fontService = FontService.shared

    var isValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty && !selectedFonts.isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Collection Name", text: $name)
                    TextField("Notes (optional)", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section {
                    ForEach(selectedFonts) { font in
                        HStack {
                            Text(font.displayName)
                                .font(.headline)
                            Spacer()
                            Button {
                                selectedFonts.removeAll { $0.id == font.id }
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }

                    Button {
                        showingFontPicker = true
                    } label: {
                        Label("Add Font", systemImage: "plus.circle.fill")
                    }
                } header: {
                    Text("Fonts (\(selectedFonts.count))")
                } footer: {
                    if selectedFonts.isEmpty {
                        Text("Add at least one font to create a collection")
                    }
                }
            }
            .navigationTitle("New Collection")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        let collection = FontCollection(
                            name: name,
                            fontNames: selectedFonts.map { $0.fontName },
                            notes: notes
                        )
                        modelContext.insert(collection)
                        try? modelContext.save()
                        HapticManager.shared.notification(.success)
                        dismiss()
                    }
                    .disabled(!isValid)
                }
            }
            .sheet(isPresented: $showingFontPicker) {
                FontPicker(selectedFont: Binding(
                    get: { nil },
                    set: { newFont in
                        if let font = newFont, !selectedFonts.contains(where: { $0.id == font.id }) {
                            selectedFonts.append(font)
                            HapticManager.shared.selectionChanged()
                        }
                    }
                ))
            }
        }
    }
}

#Preview {
    CreateCollectionView()
        .modelContainer(for: [FavoriteFont.self, FontCollection.self])
}
