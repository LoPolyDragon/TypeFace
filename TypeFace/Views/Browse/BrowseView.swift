//
//  BrowseView.swift
//  TypeFace
//
//  Main view for browsing all system fonts
//

import SwiftUI
import SwiftData

struct BrowseView: View {
    @State private var viewModel = BrowseViewModel()
    @State private var showingSettings = false
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Preview Panel
                if viewModel.selectedFont != nil {
                    FontPreviewPanel(
                        font: viewModel.selectedFont,
                        previewText: $viewModel.previewText,
                        settings: $viewModel.typographySettings,
                        onClose: {
                            viewModel.clearSelection()
                        }
                    )
                    .transition(.move(edge: .top).combined(with: .opacity))
                }

                // Font List
                ScrollView {
                    LazyVStack(spacing: 12, pinnedViews: [.sectionHeaders]) {
                        ForEach(viewModel.filteredFamilies) { family in
                            Section {
                                ForEach(family.fonts) { font in
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            viewModel.selectFont(font)
                                        }
                                    } label: {
                                        HStack {
                                            FontPreviewRow(
                                                font: font,
                                                previewText: viewModel.previewText,
                                                fontSize: 18
                                            )

                                            Spacer()

                                            NavigationLink {
                                                FontDetailView(font: font)
                                            } label: {
                                                Image(systemName: "info.circle")
                                                    .foregroundStyle(.secondary)
                                            }
                                            .buttonStyle(.plain)
                                        }
                                        .padding()
                                        .background(
                                            viewModel.selectedFont?.id == font.id
                                            ? Color.accentColor.opacity(0.1)
                                            : Color.cardBackground
                                        )
                                        .cornerRadius(12)
                                    }
                                    .buttonStyle(.plain)
                                }
                            } header: {
                                HStack {
                                    Text(family.name)
                                        .font(.headline)
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)

                                    Spacer()
                                }
                                .background(Color.appBackground)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Browse Fonts")
            .searchable(text: $viewModel.searchQuery, prompt: "Search fonts")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingSettings.toggle()
                        HapticManager.shared.impact(.light)
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            .sheet(isPresented: $showingSettings) {
                BrowseSettingsView(
                    previewText: $viewModel.previewText,
                    settings: $viewModel.typographySettings,
                    onReset: {
                        viewModel.resetSettings()
                    }
                )
            }
        }
    }
}

#Preview {
    BrowseView()
        .modelContainer(for: [FavoriteFont.self, FontCollection.self])
}
