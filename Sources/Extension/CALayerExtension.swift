//
//  CALayerExtension.swift
//  OWWTools
//
//  Created by mac on 2023/11/8.
//

import Foundation
import QuartzCore
import UIKit

extension CALayer {
    /// 设置阴影
    func setShadow(color: UIColor? = .init(hex: 0x000000, alpha: 0.05),
                   shadowOpacity: CGFloat = 1,
                   x: CGFloat = 0, y: CGFloat = -1,
                   shadowRadius: CGFloat = 8) {
        shadowOffset = CGSize(width: x, height: y)
        self.shadowRadius = shadowRadius
        shadowColor = color?.cgColor
        self.shadowOpacity = Float(shadowOpacity)
    }
}
