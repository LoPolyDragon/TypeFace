//
//  TemplateSettingsView.swift
//  TypeFace
//
//  Settings sheet for template customization
//

import SwiftUI

struct TemplateSettingsView: View {
    @Binding var settings: TypographySettings
    let onReset: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
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
            .navigationTitle("Template Settings")
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
    TemplateSettingsView(
        settings: .constant(.default),
        onReset: {}
    )
}
