//
//  TintedInteractiveButtonsDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class TintedInteractiveButtonsDemoView: UIView {
    private let resultLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let stack = addPinnedStack(spacing: 24, alignment: .center)

        stack.addArrangedSubview(DemoUI.infoLabel(
            "Tinted glass buttons with different colors to convey semantic meaning. Each button has a color tint and interactive tap feedback."
        ))

        if #available(iOS 26.0, *) {
            let buttonData: [(String, String, UIColor)] = [
                ("heart.fill", "Like", .systemRed),
                ("hand.thumbsup.fill", "Approve", .systemGreen),
                ("star.fill", "Favorite", .systemYellow),
                ("bell.fill", "Notify", .systemBlue),
                ("flame.fill", "Trending", .systemOrange),
                ("bolt.fill", "Quick Action", .systemPurple),
            ]

            let circleRow = UIStackView()
            circleRow.axis = .horizontal
            circleRow.spacing = 16
            circleRow.alignment = .center

            for (iconName, name, color) in buttonData.prefix(3) {
                circleRow.addArrangedSubview(
                    createTintedGlassButton(systemName: iconName, color: color, name: name, size: 56, cornerRadius: 28)
                )
            }
            stack.addArrangedSubview(circleRow)

            let circleRow2 = UIStackView()
            circleRow2.axis = .horizontal
            circleRow2.spacing = 16
            circleRow2.alignment = .center

            for (iconName, name, color) in buttonData.suffix(3) {
                circleRow2.addArrangedSubview(
                    createTintedGlassButton(systemName: iconName, color: color, name: name, size: 56, cornerRadius: 28)
                )
            }
            stack.addArrangedSubview(circleRow2)

            stack.addArrangedSubview(DemoUI.sectionLabel("Wide Tinted Buttons"))

            for (iconName, name, color) in buttonData.prefix(3) {
                stack.addArrangedSubview(createWideTintedButton(systemName: iconName, title: name, color: color))
            }
        } else {
            stack.addArrangedSubview(DemoUI.infoLabel("Tinted glass requires iOS 26.0+"))
        }

        resultLabel.text = "Tap any button"
        resultLabel.font = .preferredFont(forTextStyle: .footnote)
        resultLabel.textColor = .tertiaryLabel
        resultLabel.textAlignment = .center
        stack.addArrangedSubview(resultLabel)
    }

    @available(iOS 26.0, *)
    private func createTintedGlassButton(systemName: String, color: UIColor, name: String, size: CGFloat, cornerRadius: CGFloat) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        let effect = UIGlassEffect()
        let effectView = UIVisualEffectView(effect: effect)
        effectView.cornerConfiguration = .capsule(maximumRadius: cornerRadius)
        effectView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(effectView)

        let tintView = UIView()
        tintView.backgroundColor = color.withAlphaComponent(0.3)
        tintView.translatesAutoresizingMaskIntoConstraints = false
        effectView.contentView.insertSubview(tintView, at: 0)

        let icon = UIImageView(image: UIImage(systemName: systemName))
        icon.tintColor = color
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        effectView.contentView.addSubview(icon)

        let tap = UITapGestureRecognizer(target: self, action: #selector(tintedButtonTapped(_:)))
        container.addGestureRecognizer(tap)
        container.accessibilityLabel = name
        container.isUserInteractionEnabled = true

        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: size),
            container.heightAnchor.constraint(equalToConstant: size),

            effectView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            effectView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            effectView.topAnchor.constraint(equalTo: container.topAnchor),
            effectView.bottomAnchor.constraint(equalTo: container.bottomAnchor),

            tintView.leadingAnchor.constraint(equalTo: effectView.contentView.leadingAnchor),
            tintView.trailingAnchor.constraint(equalTo: effectView.contentView.trailingAnchor),
            tintView.topAnchor.constraint(equalTo: effectView.contentView.topAnchor),
            tintView.bottomAnchor.constraint(equalTo: effectView.contentView.bottomAnchor),

            icon.centerXAnchor.constraint(equalTo: effectView.contentView.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: effectView.contentView.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: size * 0.4),
            icon.heightAnchor.constraint(equalToConstant: size * 0.4),
        ])

        return container
    }

    @available(iOS 26.0, *)
    private func createWideTintedButton(systemName: String, title: String, color: UIColor) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        let effect = UIGlassEffect()
        let effectView = UIVisualEffectView(effect: effect)
        effectView.cornerConfiguration = .capsule(maximumRadius: 16)
        effectView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(effectView)

        let tintView = UIView()
        tintView.backgroundColor = color.withAlphaComponent(0.2)
        tintView.translatesAutoresizingMaskIntoConstraints = false
        effectView.contentView.insertSubview(tintView, at: 0)

        let contentStack = UIStackView()
        contentStack.axis = .horizontal
        contentStack.spacing = 10
        contentStack.alignment = .center
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        let icon = UIImageView(image: UIImage(systemName: systemName))
        icon.tintColor = color
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 24).isActive = true

        let label = UILabel()
        label.text = title
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = color

        contentStack.addArrangedSubview(icon)
        contentStack.addArrangedSubview(label)
        effectView.contentView.addSubview(contentStack)

        let tap = UITapGestureRecognizer(target: self, action: #selector(tintedButtonTapped(_:)))
        container.addGestureRecognizer(tap)
        container.accessibilityLabel = title
        container.isUserInteractionEnabled = true

        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: 200),
            container.heightAnchor.constraint(equalToConstant: 50),

            effectView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            effectView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            effectView.topAnchor.constraint(equalTo: container.topAnchor),
            effectView.bottomAnchor.constraint(equalTo: container.bottomAnchor),

            tintView.leadingAnchor.constraint(equalTo: effectView.contentView.leadingAnchor),
            tintView.trailingAnchor.constraint(equalTo: effectView.contentView.trailingAnchor),
            tintView.topAnchor.constraint(equalTo: effectView.contentView.topAnchor),
            tintView.bottomAnchor.constraint(equalTo: effectView.contentView.bottomAnchor),

            contentStack.centerXAnchor.constraint(equalTo: effectView.contentView.centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: effectView.contentView.centerYAnchor),
        ])

        return container
    }

    @objc private func tintedButtonTapped(_ sender: UITapGestureRecognizer) {
        let name = sender.view?.accessibilityLabel ?? "Button"
        resultLabel.text = "\(name) tapped!"

        if let view = sender.view {
            UIView.animate(withDuration: 0.1, animations: {
                view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }, completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    view.transform = .identity
                }
            })
        }
    }
}
