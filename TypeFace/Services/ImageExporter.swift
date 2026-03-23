//
//  ImageExporter.swift
//  TypeFace
//
//  Service for exporting views as high-resolution PNG images
//

import SwiftUI
import UIKit

final class ImageExporter {
    static let shared = ImageExporter()

    private init() {}

    @MainActor
    func exportView<Content: View>(_ view: Content, size: CGSize, scale: CGFloat = 3.0) -> UIImage? {
        let controller = UIHostingController(rootView: view)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            controller.view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }

    @MainActor
    func exportToImageData<Content: View>(_ view: Content, size: CGSize, scale: CGFloat = 3.0) -> Data? {
        guard let image = exportView(view, size: size, scale: scale) else { return nil }
        return image.pngData()
    }

    func saveToPhotos(_ image: UIImage, completion: @escaping (Result<Void, Error>) -> Void) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        completion(.success(()))
    }
}
