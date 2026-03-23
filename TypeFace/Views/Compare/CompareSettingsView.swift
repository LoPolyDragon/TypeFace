//
//  CompareSettingsView.swift
//  TypeFace
//
//  Settings sheet for comparison customization
//

import SwiftUI

struct CompareSettingsView: View {
    @Binding var text: String
    @Binding var settings: TypographySettings
    let onReset: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Comparison Text", text: $text, axis: .vertical)
                        .lineLimit(3...10)
                } header: {
                    Text("Text")
                } footer: {
                    Text("This text will be displayed in all comparison panels")
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
            .navigationTitle("Comparison Settings")
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
    CompareSettingsView(
        text: .constant("The quick brown fox"),
        settings: .constant(.default),
        onReset: {}
    )
}
