//
//  TextView.swift
//  
//
//  Created by Lww on 2024/6/12.
//

import UIKit

@objc protocol TextViewDelegate: AnyObject {
    @objc optional func textViewDidEndEditing(_ textView: UITextView)
    /// 监听文字的变化
    @objc optional func textViewDidChange(_ textView: UITextView)
}

public class TextView: UITextView {
    public override var text: String! {
        didSet {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }

    var maxLength: Int?

    private let placeholderLabel = UILabel()

    public var placeholder: String? {
        get {
            return placeholderLabel.text
        }
        set {
            placeholderLabel.text = newValue
            setNeedsLayout()
        }
    }

    weak var myDelegate: TextViewDelegate?

    public init() {
        super.init(frame: .zero, textContainer: nil)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func configure() {
        addSubview(placeholderLabel)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.textColor = UIColor.gray.withAlphaComponent(0.2)
        placeholderLabel.numberOfLines = 0
        placeholderLabel.font = UIFont.systemFont(ofSize: 14)
        placeholderLabel.isHidden = !text.isEmpty
        textContainerInset = UIEdgeInsets(top: 12, left: 9, bottom: 8, right: 8)
        delegate = self

        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
        ])
    }
}

extension TextView: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !text.isEmpty
        if let maxLength = maxLength {
            if text.count > maxLength {
                let index = text.index(text.startIndex, offsetBy: maxLength)
                text = String(text[..<index])
            }
        }

        myDelegate?.textViewDidChange?(textView)
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        myDelegate?.textViewDidEndEditing?(textView)
    }
}
