//
//  CompareView.swift
//  TypeFace
//
//  Main view for side-by-side font comparison
//

import SwiftUI

struct CompareView: View {
    @State private var viewModel = CompareViewModel()
    @State private var showingSettings = false
    @State private var showingFontPicker = false
    @State private var selectedPanelIndex = 0
    @State private var showingExportOptions = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // Panel Count Selector
                HStack {
                    Text("Panels")
                        .font(.subheadline.weight(.medium))

                    Picker("Panels", selection: $viewModel.numberOfPanels) {
                        Text("2").tag(2)
                        Text("3").tag(3)
                        Text("4").tag(4)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 150)

                    Spacer()
                }
                .padding(.horizontal)

                // Comparison Panels
                ScrollView {
                    if viewModel.numberOfPanels == 2 {
                        VStack(spacing: 16) {
                            ForEach(0..<2, id: \.self) { index in
                                ComparisonPanel(
                                    font: viewModel.selectedFonts[index],
                                    text: viewModel.comparisonText,
                                    settings: viewModel.typographySettings,
                                    onSelectFont: {
                                        selectedPanelIndex = index
                                        showingFontPicker = true
                                    },
                                    onRemoveFont: {
                                        viewModel.removeFont(at: index)
                                    }
                                )
                            }
                        }
                    } else {
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: 16),
                                GridItem(.flexible(), spacing: 16)
                            ],
                            spacing: 16
                        ) {
                            ForEach(0..<viewModel.numberOfPanels, id: \.self) { index in
                                ComparisonPanel(
                                    font: viewModel.selectedFonts[index],
                                    text: viewModel.comparisonText,
                                    settings: viewModel.typographySettings,
                                    onSelectFont: {
                                        selectedPanelIndex = index
                                        showingFontPicker = true
                                    },
                                    onRemoveFont: {
                                        viewModel.removeFont(at: index)
                                    }
                                )
                                .frame(height: 300)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Compare Fonts")
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
                        .disabled(viewModel.activeFonts.isEmpty)

                        Divider()

                        Button(role: .destructive) {
                            viewModel.clearAll()
                        } label: {
                            Label("Clear All", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .sheet(isPresented: $showingFontPicker) {
                FontPicker(selectedFont: Binding(
                    get: { viewModel.selectedFonts[selectedPanelIndex] },
                    set: { newFont in
                        if let font = newFont {
                            viewModel.selectFont(font, at: selectedPanelIndex)
                        }
                    }
                ))
            }
            .sheet(isPresented: $showingSettings) {
                CompareSettingsView(
                    text: $viewModel.comparisonText,
                    settings: $viewModel.typographySettings,
                    onReset: {
                        viewModel.resetSettings()
                    }
                )
            }
            .sheet(isPresented: $showingExportOptions) {
                ExportView(
                    content: ComparisonExportView(
                        fonts: viewModel.activeFonts,
                        text: viewModel.comparisonText,
                        settings: viewModel.typographySettings
                    )
                )
            }
        }
    }
}

#Preview {
    CompareView()
}
