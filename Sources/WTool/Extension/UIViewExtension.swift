//
//  UIViewExtension.swift
//  OWWTools
//
//  Created by mac on 2023/11/8.
//

import Foundation
import SnapKit
import UIKit

extension UIView {
    /// 获取 UIView 字符串
    public static var describing: String {
        String(describing: Self.self)
    }
}

public extension UIView {
    public var safeAreaTop: ConstraintItem {
        return safeAreaLayoutGuide.snp.top
    }

    public var safeAreaBottom: ConstraintItem {
        return safeAreaLayoutGuide.snp.bottom
    }

    public var safeTop: CGFloat {
        return safeAreaLayoutGuide.layoutFrame.minY
    }

    public var safeBottom: CGFloat {
        return frame.size.height - safeTop - safeAreaLayoutGuide.layoutFrame.height
    }

    public var safeAreaHeight: CGFloat {
        return frame.size.height - safeTop - safeBottom
    }
}

extension UIView {
    /// 给所有 UIView 添加点击事件
    public func addTapGestureRecognizer(action: ((UITapGestureRecognizer) -> Void)?) {
        isUserInteractionEnabled = true
        let tapGestureRecognizer = BlockTapGestureRecognizer(action: action)
        addGestureRecognizer(tapGestureRecognizer)
    }
}

class BlockTapGestureRecognizer: UITapGestureRecognizer {
    private var tapAction: ((UITapGestureRecognizer) -> Void)?

    init(action: ((UITapGestureRecognizer) -> Void)?) {
        tapAction = action
        super.init(target: nil, action: nil)
        addTarget(self, action: #selector(didTap))
    }

    @objc private func didTap(sender: UITapGestureRecognizer) {
        DispatchQueue.main.async {
            self.tapAction?(sender)
        }
    }
}

extension UIView {
    /// UIView 每个角指定不同的原价 并且设置边框和颜色
    public func setCornerRadius(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0, borderWidth: CGFloat = 0, borderColor: UIColor = .clear) {
        let path = UIBezierPath()

        path.move(to: CGPoint(x: bounds.minX + topLeft, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX - topRight, y: bounds.minY))
        path.addArc(withCenter: CGPoint(x: bounds.maxX - topRight, y: bounds.minY + topRight), radius: topRight, startAngle: -.pi / 2, endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY - bottomRight))
        path.addArc(withCenter: CGPoint(x: bounds.maxX - bottomRight, y: bounds.maxY - bottomRight), radius: bottomRight, startAngle: 0, endAngle: .pi / 2, clockwise: true)
        path.addLine(to: CGPoint(x: bounds.minX + bottomLeft, y: bounds.maxY))
        path.addArc(withCenter: CGPoint(x: bounds.minX + bottomLeft, y: bounds.maxY - bottomLeft), radius: bottomLeft, startAngle: .pi / 2, endAngle: .pi, clockwise: true)
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.minY + topLeft))
        path.addArc(withCenter: CGPoint(x: bounds.minX + topLeft, y: bounds.minY + topLeft), radius: topLeft, startAngle: .pi, endAngle: -.pi / 2, clockwise: true)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer

        // 设置边框
        if borderWidth > 0 {
            let borderLayer = CAShapeLayer()
            borderLayer.path = path.cgPath
            borderLayer.lineWidth = borderWidth
            borderLayer.strokeColor = borderColor.cgColor
            borderLayer.fillColor = UIColor.clear.cgColor
            layer.addSublayer(borderLayer)
        }
    }

    /// 指定边框位置
    public func addBorder(to side: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor

        switch side {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.size.height - thickness, width: frame.size.width, height: thickness)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.size.height)
        case .right:
            border.frame = CGRect(x: frame.size.width - thickness, y: 0, width: thickness, height: frame.size.height)
        default:
            break
        }

        layer.addSublayer(border)
    }
}

public extension UIView {
    var xValue: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }

    var yValue: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }

    var left: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame = CGRect(x: newValue, y: top, width: width, height: height)
        }
    }

    var top: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame = CGRect(x: left, y: newValue, width: width, height: height)
        }
    }

    var right: CGFloat {
        get {
            return left + width
        }
        set {
            frame = CGRect(x: newValue - width, y: top, width: width, height: height)
        }
    }

    var bottom: CGFloat {
        get {
            return top + height
        }
        set {
            frame = CGRect(x: left, y: newValue - height, width: width, height: height)
        }
    }

    var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }

    var centerY: CGFloat {
        get {
            return center.y
        }
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }

    var width: CGFloat {
        get {
            return bounds.size.width
        }
        set {
            frame.size = CGSize(width: newValue, height: frame.height)
        }
    }

    var height: CGFloat {
        get {
            return bounds.size.height
        }
        set {
            frame = CGRect(origin: frame.origin, size: CGSize(width: width, height: newValue))
        }
    }

    var halfWidth: CGFloat {
        return width / 2
    }

    var halfHeight: CGFloat {
        return height / 2
    }

    var size: CGSize {
        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }
}
