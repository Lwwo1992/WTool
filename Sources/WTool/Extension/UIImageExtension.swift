//
//  UIImageExtension.swift
//  LoveDiary
//
//  Created by mac on 2023/12/1.
//

import AVFoundation
import Foundation
import UIKit

extension UIImage {
    /// 修行图片的透明度
    public func changeImageOpacity(opacity: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        draw(in: rect, blendMode: .normal, alpha: opacity)
        let modifiedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return modifiedImage
    }
}
