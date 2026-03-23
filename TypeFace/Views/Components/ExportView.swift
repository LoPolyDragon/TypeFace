//
//  ExportView.swift
//  TypeFace
//
//  Universal export sheet for exporting views as images
//

import SwiftUI
import UIKit

struct ExportView<Content: View>: View {
    let content: Content

    @Environment(\.dismiss) private var dismiss
    @State private var exportSize: ExportSize = .high
    @State private var isExporting = false
    @State private var exportedImage: UIImage?
    @State private var showingShareSheet = false
    @State private var showingSuccessAlert = false

    enum ExportSize: String, CaseIterable {
        case medium = "Medium (2x)"
        case high = "High (3x)"
        case ultra = "Ultra (4x)"

        var scale: CGFloat {
            switch self {
            case .medium: return 2.0
            case .high: return 3.0
            case .ultra: return 4.0
            }
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Preview
                    content
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 10)

                    // Export Options
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Export Quality")
                            .font(.headline)

                        Picker("Quality", selection: $exportSize) {
                            ForEach(ExportSize.allCases, id: \.self) { size in
                                Text(size.rawValue).tag(size)
                            }
                        }
                        .pickerStyle(.segmented)

                        Text("Higher quality produces larger file sizes but better resolution for printing and high-DPI displays.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(Color.cardBackground)
                    .cornerRadius(12)

                    // Export Buttons
                    VStack(spacing: 12) {
                        Button {
                            exportImage()
                        } label: {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Share Image")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                        }
                        .disabled(isExporting)

                        Button {
                            saveToFiles()
                        } label: {
                            HStack {
                                Image(systemName: "arrow.down.doc")
                                Text("Save to Files")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.cardBackground)
                            .foregroundStyle(.primary)
                            .cornerRadius(12)
                        }
                        .disabled(isExporting)
                    }

                    if isExporting {
                        ProgressView("Exporting...")
                            .padding()
                    }
                }
                .padding()
            }
            .navigationTitle("Export")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingShareSheet) {
                if let image = exportedImage {
                    ShareSheet(items: [image])
                }
            }
            .alert("Saved Successfully", isPresented: $showingSuccessAlert) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text("The image has been saved to your Files")
            }
        }
    }

    private func exportImage() {
        isExporting = true
        HapticManager.shared.impact(.medium)

        Task { @MainActor in
            let size = CGSize(width: 1200, height: 1200)
            if let image = ImageExporter.shared.exportView(content, size: size, scale: exportSize.scale) {
                exportedImage = image
                showingShareSheet = true
                HapticManager.shared.notification(.success)
            }
            isExporting = false
        }
    }

    private func saveToFiles() {
        isExporting = true
        HapticManager.shared.impact(.medium)

        Task { @MainActor in
            let size = CGSize(width: 1200, height: 1200)
            if let image = ImageExporter.shared.exportView(content, size: size, scale: exportSize.scale),
               let data = image.pngData() {
                let filename = "TypeFace-Export-\(Date().ISO8601Format()).png"
                saveImageToFiles(data: data, filename: filename)
                HapticManager.shared.notification(.success)
                showingSuccessAlert = true
            }
            isExporting = false
        }
    }

    private func saveImageToFiles(data: Data, filename: String) {
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)
        try? data.write(to: tempURL)
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    ExportView(
        content: Text("Preview Content")
            .font(.largeTitle)
            .padding(40)
    )
}
