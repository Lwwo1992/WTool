//
//  File.swift
//
//
//  Created by Lww on 2024/6/14.
//

import UIKit

public extension String {
    /// 计算字体内容宽度
    /// - Parameter font: 当前文字大小
    /// - Returns: 内容宽度
    func textWidth(font: UIFont) -> CGFloat {
        let str = self as NSString
        let size = CGSize(width: 20000, height: 100)
        let attributes = [NSAttributedString.Key.font: font]
        let labelSize = str.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
        return labelSize.width
    }

    /// 计算字体内容高度
    /// - Parameters:
    ///   - textWidth: 当前宽度
    ///   - font: 当前文字大小
    /// - Returns: 内容高度
    func textHeight(textWidth: CGFloat, font: UIFont) -> CGFloat {
        let constraintSize = CGSize(width: textWidth, height: .greatestFiniteMagnitude)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 20.0 / font.lineHeight
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .paragraphStyle: paragraphStyle]
        let textNSString = self as NSString
        let boundingRect = textNSString.boundingRect(with: constraintSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        let height = ceil(boundingRect.height)
        return height
    }

    public func firstCharacter() -> String {
        String(prefix(1))
    }

    /// 将字符串转换为图片
    /// - Parameters:
    ///   - font: 用于绘制文本的字体
    ///   - size: 图片的大小
    /// - Returns: 包含文本的 UIImage
    public func image(font: UIFont, size: CGSize) -> UIImage? {
        // 创建一个绘制上下文
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

        // 确保绘制上下文存在
        guard let context = UIGraphicsGetCurrentContext() else { return nil }

        // 设置文本属性
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: textStyle,
            .foregroundColor: UIColor.black,
        ]

        // 计算文本的大小
        let textSize = (self as NSString).size(withAttributes: attributes)
        let textRect = CGRect(
            x: (size.width - textSize.width) / 2,
            y: (size.height - textSize.height) / 2,
            width: textSize.width,
            height: textSize.height
        )

        // 绘制文本
        (self as NSString).draw(in: textRect, withAttributes: attributes)

        // 获取绘制的图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}
