//
//  File.swift
//
//
//  Created by Lww on 2024/6/12.
//

import Foundation
import UIKit

public class Button: UIButton {
    public var tapAction: (() -> Void)?
    public var tapActionHandler: ((_ sender: Button) -> Void)?

    public var ableClick: Bool = false {
        didSet {
            if ableClick {
                isUserInteractionEnabled = true
                titleColor(UIColor.black)
            } else {
                isUserInteractionEnabled = false
                titleColor(UIColor.black.withAlphaComponent(0.6))
            }
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: .zero)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        adjustsImageWhenHighlighted = false
        setTitleColor(.black, for: .normal)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @discardableResult
    public func title(_ title: String, for state: UIControl.State = .normal) -> Self {
        setTitle(title, for: state)
        return self
    }

    @discardableResult
    public func image(_ image: UIImage, for state: UIControl.State = .normal) -> Self {
        setImage(image, for: state)
        return self
    }

    @discardableResult
    public func backgroundImage(_ image: UIImage, for state: UIControl.State = .normal) -> Self {
        setBackgroundImage(image, for: state)
        return self
    }

    @discardableResult
    public func backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }

    @discardableResult
    public func titleColor(_ color: UIColor, for state: UIControl.State = .normal) -> Self {
        setTitleColor(color, for: state)
        return self
    }

    @discardableResult
    public func titleFont(_ font: UIFont) -> Self {
        titleLabel?.font = font
        return self
    }

    @discardableResult
    public func cornerRadius(_ radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        return self
    }

    @discardableResult
    public func borderWidth(_ width: CGFloat, color: UIColor) -> Self {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        return self
    }

    @objc private func buttonTapped() {
        tapAction?()
        tapActionHandler?(self)
    }
}

extension UIButton {
    public func setHitAreaEdgeInsets(_ edgeInsets: UIEdgeInsets) {
        let hitArea = UIEdgeInsets(top: -edgeInsets.top, left: -edgeInsets.left, bottom: -edgeInsets.bottom, right: -edgeInsets.right)
        let buttonBounds = bounds
        let extendedBounds = buttonBounds.inset(by: hitArea)
        hitAreaEdgeInsets = hitArea
        frame = extendedBounds
    }

    private struct AssociatedKeys {
        static var hitAreaEdgeInsets = UIEdgeInsets()
    }

    private var hitAreaEdgeInsets: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.hitAreaEdgeInsets) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.hitAreaEdgeInsets, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let hitAreaEdgeInsets = hitAreaEdgeInsets {
            let hitFrame = bounds.inset(by: hitAreaEdgeInsets)
            return hitFrame.contains(point)
        }
        return super.point(inside: point, with: event)
    }
}
