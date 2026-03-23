//
//  BrowseSettingsView.swift
//  TypeFace
//
//  Settings sheet for browse preview customization
//

import SwiftUI

struct BrowseSettingsView: View {
    @Binding var previewText: String
    @Binding var settings: TypographySettings
    let onReset: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Preview Text", text: $previewText, axis: .vertical)
                        .lineLimit(3...6)
                } header: {
                    Text("Preview Text")
                } footer: {
                    Text("This text will be used to preview all fonts in the browse list")
                }

                Section("Typography") {
                    TypographyControls(settings: $settings)
                }

                Section {
                    Button("Reset to Defaults") {
                        onReset()
                        dismiss()
                    }
                    .foregroundStyle(.red)
                }
            }
            .navigationTitle("Preview Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    BrowseSettingsView(
        previewText: .constant("The quick brown fox"),
        settings: .constant(.default),
        onReset: {}
    )
}
