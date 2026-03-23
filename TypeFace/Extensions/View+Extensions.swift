//
//  View+Extensions.swift
//  TypeFace
//
//  Extensions for SwiftUI views
//

import SwiftUI

extension View {
    func fontPreviewCard() -> some View {
        self
            .padding()
            .background(Color(uiColor: .secondarySystemGroupedBackground))
            .cornerRadius(12)
    }

    func cardStyle() -> some View {
        self
            .background(Color(uiColor: .secondarySystemGroupedBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }

    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    func snapshot(size: CGSize) -> UIImage? {
        let controller = UIHostingController(rootView: self)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            controller.view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

extension Text {
    func applyTypographySettings(_ settings: TypographySettings, fontName: String) -> some View {
        self
            .font(.custom(fontName, size: settings.fontSize))
            .foregroundStyle(settings.textColor.color)
            .kerning(settings.letterSpacing)
            .lineSpacing(settings.fontSize * (settings.lineHeight - 1))
            .multilineTextAlignment(settings.alignment.textAlignment)
    }
}
