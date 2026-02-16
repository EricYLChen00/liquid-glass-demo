//
//  GlassContainerDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class GlassContainerDemoView: UIView {

    private var glassChildren: [UIVisualEffectView] = []
    private let statusLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        let infoLabel = createInfoLabel(
            "UIGlassContainerEffect groups multiple glass views together. This enables morphing animation between them and improves performance by sharing a single CABackdropLayer.\n\nTap Add/Remove to see the morphing animation."
        )
        stack.addArrangedSubview(infoLabel)

        if #available(iOS 26.0, *) {
            // Container
            let containerEffect = UIGlassContainerEffect()
            let containerView = UIVisualEffectView(effect: containerEffect)
            containerView.translatesAutoresizingMaskIntoConstraints = false

            let childrenStack = UIStackView()
            childrenStack.axis = .horizontal
            childrenStack.spacing = 12
            childrenStack.alignment = .center
            childrenStack.translatesAutoresizingMaskIntoConstraints = false
            containerView.contentView.addSubview(childrenStack)

            NSLayoutConstraint.activate([
                containerView.heightAnchor.constraint(equalToConstant: 80),
                childrenStack.centerXAnchor.constraint(equalTo: containerView.contentView.centerXAnchor),
                childrenStack.centerYAnchor.constraint(equalTo: containerView.contentView.centerYAnchor),
                childrenStack.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.contentView.leadingAnchor, constant: 8),
                childrenStack.trailingAnchor.constraint(lessThanOrEqualTo: containerView.contentView.trailingAnchor, constant: -8),
            ])

            // Initial children
            let icons = ["heart.fill", "star.fill", "bell.fill"]
            for iconName in icons {
                let child = createGlassChild(systemName: iconName)
                childrenStack.addArrangedSubview(child)
                glassChildren.append(child)
            }

            stack.addArrangedSubview(containerView)

            // Buttons
            let buttonStack = UIStackView()
            buttonStack.axis = .horizontal
            buttonStack.spacing = 12
            buttonStack.distribution = .fillEqually

            let addButton = createActionButton(title: "Add", action: #selector(addChild))
            let removeButton = createActionButton(title: "Remove", action: #selector(removeChild))

            buttonStack.addArrangedSubview(addButton)
            buttonStack.addArrangedSubview(removeButton)
            stack.addArrangedSubview(buttonStack)

            // Tag the stack for later access
            childrenStack.tag = 100
            containerView.tag = 200
        } else {
            stack.addArrangedSubview(createInfoLabel("UIGlassContainerEffect requires iOS 26.0+"))
        }

        statusLabel.text = "3 glass children"
        statusLabel.font = .preferredFont(forTextStyle: .footnote)
        statusLabel.textColor = .tertiaryLabel
        statusLabel.textAlignment = .center
        stack.addArrangedSubview(statusLabel)
    }

    private let extraIcons = ["bookmark.fill", "bolt.fill", "flame.fill", "leaf.fill", "drop.fill"]
    private var extraIconIndex = 0

    @available(iOS 26.0, *)
    @objc private func addChild() {
        guard let childrenStack = viewWithTag(100) as? UIStackView else { return }
        guard glassChildren.count < 8 else {
            statusLabel.text = "Max 8 children"
            return
        }

        let iconName = extraIcons[extraIconIndex % extraIcons.count]
        extraIconIndex += 1
        let child = createGlassChild(systemName: iconName)

        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5) {
            childrenStack.addArrangedSubview(child)
            self.glassChildren.append(child)
            self.layoutIfNeeded()
        }
        statusLabel.text = "\(glassChildren.count) glass children"
    }

    @objc private func removeChild() {
        guard let childrenStack = viewWithTag(100) as? UIStackView else { return }
        guard let last = glassChildren.popLast() else {
            statusLabel.text = "No children to remove"
            return
        }

        UIView.animate(withDuration: 0.3) {
            last.alpha = 0
            last.isHidden = true
            self.layoutIfNeeded()
        } completion: { _ in
            childrenStack.removeArrangedSubview(last)
            last.removeFromSuperview()
        }
        statusLabel.text = "\(glassChildren.count) glass children"
    }

    @available(iOS 26.0, *)
    private func createGlassChild(systemName: String) -> UIVisualEffectView {
        let childEffect = UIGlassEffect()
        let childView = UIVisualEffectView(effect: childEffect)
        childView.translatesAutoresizingMaskIntoConstraints = false
        childView.cornerConfiguration = .capsule(maximumRadius: 22)

        let icon = UIImageView(image: UIImage(systemName: systemName))
        icon.tintColor = .label
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        childView.contentView.addSubview(icon)

        NSLayoutConstraint.activate([
            childView.widthAnchor.constraint(equalToConstant: 44),
            childView.heightAnchor.constraint(equalToConstant: 44),
            icon.centerXAnchor.constraint(equalTo: childView.contentView.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: childView.contentView.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 22),
            icon.heightAnchor.constraint(equalToConstant: 22),
        ])

        return childView
    }

    private func createActionButton(title: String, action: Selector) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.cornerStyle = .medium
        let button = UIButton(configuration: config)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    private func createInfoLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }
}
