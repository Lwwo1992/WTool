//
//  UIViewExtension.swift
//  OWWTools
//
//  Created by mac on 2023/11/8.
//

import Foundation
import UIKit

extension UIView {
    /// 获取 UIView 字符串
    static var describing: String {
        String(describing: Self.self)
    }
}

extension UIView {
    /// 给所有 UIView 添加点击事件
    func addTapGestureRecognizer(action: ((UITapGestureRecognizer) -> Void)?) {
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
    func setCornerRadius(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0, borderWidth: CGFloat = 0, borderColor: UIColor = .clear) {
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
}
