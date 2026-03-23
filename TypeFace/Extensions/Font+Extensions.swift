//
//  Font+Extensions.swift
//  TypeFace
//
//  Extensions for Font and UIFont
//

import SwiftUI
import UIKit

extension Font {
    static func custom(_ fontInfo: FontInfo, size: CGFloat) -> Font {
        Font.custom(fontInfo.fontName, size: size)
    }

    static func custom(_ fontName: String, size: CGFloat, relativeTo textStyle: Font.TextStyle) -> Font {
        Font.custom(fontName, size: size, relativeTo: textStyle)
    }
}

extension UIFont {
    convenience init?(fontInfo: FontInfo, size: CGFloat) {
        self.init(name: fontInfo.fontName, size: size)
    }
}
