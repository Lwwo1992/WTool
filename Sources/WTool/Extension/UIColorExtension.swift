//
//  UIColorExtension.swift
//  OWWTools
//
//  Created by mac on 2023/11/8.
//

import SwiftUI
import UIKit

#if canImport(SwiftUI) && os(iOS)
    @available(iOS 13.0, *)
    public extension Color {
        init(hex: UInt, alpha: Double = 1) {
            self.init(
                .sRGB,
                red: Double((hex >> 16) & 0xFF) / 255,
                green: Double((hex >> 08) & 0xFF) / 255,
                blue: Double((hex >> 00) & 0xFF) / 255,
                opacity: alpha
            )
        }
    }
#endif
