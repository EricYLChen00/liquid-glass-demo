//
//  DemoUI.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/19.
//

import UIKit

enum DemoUI {
    static func infoLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }

    static func actionButton(
        title: String,
        target: Any,
        action: Selector,
        size: UIButton.Configuration.Size = .medium
    ) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.cornerStyle = .medium
        config.buttonSize = size
        let button = UIButton(configuration: config)
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }

    static func sectionLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .label
        return label
    }
}

extension UIView {
    func addPinnedStack(
        spacing: CGFloat = 16,
        alignment: UIStackView.Alignment = .fill
    ) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = spacing
        stack.alignment = alignment
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        return stack
    }
}
