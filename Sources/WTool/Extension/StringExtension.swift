//
//  File.swift
//
//
//  Created by Lww on 2024/6/14.
//

import Foundation

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
}
