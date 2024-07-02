//
//  Label.swift
//  
//
//  Created by Lww on 2024/6/12.
//

import UIKit

public class Label: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .left
        numberOfLines = 0
        textColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @discardableResult
    public func text(_ text: String) -> Label {
        self.text = text
        return self
    }

    @discardableResult
    public func textColor(_ color: UIColor) -> Label {
        textColor = color
        return self
    }

    @discardableResult
    public func font(_ font: UIFont) -> Label {
        self.font = font
        return self
    }

    @discardableResult
    public func backgroundColor(_ color: UIColor) -> Label {
        backgroundColor = color
        return self
    }

    @discardableResult
    public func textAlignment(_ alignment: NSTextAlignment) -> Label {
        textAlignment = alignment
        return self
    }

    @discardableResult
    public func cornerRadius(_ radius: CGFloat) -> Label {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        return self
    }

    @discardableResult
    public func borderWidth(_ width: CGFloat, color: UIColor) -> Label {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        return self
    }
}
