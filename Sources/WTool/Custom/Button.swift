//
//  File.swift
//
//
//  Created by Lww on 2024/6/12.
//

import Foundation

class Button: UIButton {
    var tapAction: (() -> Void)?
    var tapActionHandler: ((_ sender: Button) -> Void)?

    var ableClick: Bool = false {
        didSet {
            if ableClick {
                self.isUserInteractionEnabled = true
                self.titleColor(UIColor.black)
            } else {
                self.isUserInteractionEnabled = false
                self.titleColor(UIColor.black.withAlphaComponent(0.6))
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        adjustsImageWhenHighlighted = false
        setTitleColor(.black, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @discardableResult
    func title(_ title: String, for state: UIControl.State = .normal) -> Self {
        setTitle(title, for: state)
        return self
    }

    @discardableResult
    func image(_ image: UIImage, for state: UIControl.State = .normal) -> Self {
        setImage(image, for: state)
        return self
    }

    @discardableResult
    func backgroundImage(_ image: UIImage, for state: UIControl.State = .normal) -> Self {
        setBackgroundImage(image, for: state)
        return self
    }

    @discardableResult
    func backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }

    @discardableResult
    func titleColor(_ color: UIColor, for state: UIControl.State = .normal) -> Self {
        setTitleColor(color, for: state)
        return self
    }

    @discardableResult
    func titleFont(_ font: UIFont) -> Self {
        titleLabel?.font = font
        return self
    }

    @discardableResult
    func cornerRadius(_ radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        return self
    }

    @discardableResult
    func borderWidth(_ width: CGFloat, color: UIColor) -> Self {
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
    func setHitAreaEdgeInsets(_ edgeInsets: UIEdgeInsets) {
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
