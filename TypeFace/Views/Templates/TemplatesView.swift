//
//  TemplatesView.swift
//  TypeFace
//
//  Main view for template scene mockups
//

import SwiftUI

struct TemplatesView: View {
    @State private var viewModel = TemplatesViewModel()
    @State private var showingFontPicker = false
    @State private var showingSettings = false
    @State private var showingExportOptions = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Template Selector
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(SceneTemplate.allCases) { template in
                                TemplateCard(
                                    template: template,
                                    isSelected: viewModel.selectedTemplate == template
                                ) {
                                    viewModel.selectTemplate(template)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Font Selection
                    Button {
                        showingFontPicker = true
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Font")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)

                                if let font = viewModel.selectedFont {
                                    Text(font.displayName)
                                        .font(.headline)
                                    Text(font.familyName)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                } else {
                                    Text("Choose a font")
                                        .font(.headline)
                                        .foregroundStyle(.secondary)
                                }
                            }

                            Spacer()

                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                        .padding()
                        .background(Color.cardBackground)
                        .cornerRadius(12)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal)

                    // Template Preview
                    if let font = viewModel.selectedFont {
                        TemplatePreview(
                            template: viewModel.selectedTemplate,
                            font: font,
                            text: viewModel.displayText,
                            settings: viewModel.typographySettings
                        )
                        .padding(.horizontal)
                    } else {
                        VStack(spacing: 16) {
                            Image(systemName: "textformat.alt")
                                .font(.system(size: 60))
                                .foregroundStyle(.secondary)
                            Text("Select a font to preview")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                        .background(Color.cardBackground)
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }

                    // Custom Text Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Custom Text")
                            .font(.subheadline.weight(.medium))

                        TextField("Enter text", text: $viewModel.customText, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                            .lineLimit(3...8)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Templates")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Button {
                            showingSettings = true
                        } label: {
                            Label("Typography Settings", systemImage: "slider.horizontal.3")
                        }

                        Button {
                            showingExportOptions = true
                        } label: {
                            Label("Export", systemImage: "square.and.arrow.up")
                        }
                        .disabled(viewModel.selectedFont == nil)

                        Divider()

                        Button {
                            viewModel.resetToDefaults()
                        } label: {
                            Label("Reset to Defaults", systemImage: "arrow.counterclockwise")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .sheet(isPresented: $showingFontPicker) {
                FontPicker(selectedFont: $viewModel.selectedFont)
            }
            .sheet(isPresented: $showingSettings) {
                TemplateSettingsView(
                    settings: $viewModel.typographySettings,
                    onReset: {
                        viewModel.resetToDefaults()
                    }
                )
            }
            .sheet(isPresented: $showingExportOptions) {
                if let font = viewModel.selectedFont {
                    ExportView(
                        content: TemplatePreview(
                            template: viewModel.selectedTemplate,
                            font: font,
                            text: viewModel.displayText,
                            settings: viewModel.typographySettings
                        )
                    )
                }
            }
        }
    }
}

#Preview {
    TemplatesView()
}
