//
//  TextField.swift
//
//
//  Created by Lww on 2024/6/12.
//

import UIKit

public class TextField: UITextField {
    public var padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    public var maxLength: Int?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        delegate = self
        addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension TextField: UITextFieldDelegate {
    @objc func textFieldDidChange(textField: UITextField) {
        guard let text = textField.text, let count = maxLength else {
            return
        }

        if textField.markedTextRange != nil {
            return
        }

        let textCount = text.count
        let minCount = min(textCount, count)
        self.text = (text as NSString).substring(to: minCount)
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        resignFirstResponder()
        return true
    }
}
