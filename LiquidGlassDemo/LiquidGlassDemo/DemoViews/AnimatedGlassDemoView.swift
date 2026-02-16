//
//  AnimatedGlassDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class AnimatedGlassDemoView: UIView {

    private var effectView: UIVisualEffectView?
    private var isGlassVisible = false
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
        stack.spacing = 24
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
            "Animate glass materialization and dematerialization by toggling the UIVisualEffectView's effect property inside UIView.animate."
        )
        stack.addArrangedSubview(infoLabel)

        if #available(iOS 26.0, *) {
            // Glass view container
            let glassContainer = UIView()
            glassContainer.translatesAutoresizingMaskIntoConstraints = false
            glassContainer.heightAnchor.constraint(equalToConstant: 150).isActive = true
            glassContainer.widthAnchor.constraint(equalToConstant: 250).isActive = true

            let ev = UIVisualEffectView()
            ev.cornerConfiguration = .capsule(maximumRadius: 20)
            ev.translatesAutoresizingMaskIntoConstraints = false
            glassContainer.addSubview(ev)

            let icon = UIImageView(image: UIImage(systemName: "wand.and.stars"))
            icon.tintColor = .label
            icon.contentMode = .scaleAspectFit
            icon.translatesAutoresizingMaskIntoConstraints = false
            ev.contentView.addSubview(icon)

            let label = UILabel()
            label.text = "Animated Glass"
            label.font = .preferredFont(forTextStyle: .headline)
            label.translatesAutoresizingMaskIntoConstraints = false
            ev.contentView.addSubview(label)

            NSLayoutConstraint.activate([
                ev.leadingAnchor.constraint(equalTo: glassContainer.leadingAnchor),
                ev.trailingAnchor.constraint(equalTo: glassContainer.trailingAnchor),
                ev.topAnchor.constraint(equalTo: glassContainer.topAnchor),
                ev.bottomAnchor.constraint(equalTo: glassContainer.bottomAnchor),

                icon.centerXAnchor.constraint(equalTo: ev.contentView.centerXAnchor),
                icon.centerYAnchor.constraint(equalTo: ev.contentView.centerYAnchor, constant: -16),
                icon.widthAnchor.constraint(equalToConstant: 40),
                icon.heightAnchor.constraint(equalToConstant: 40),

                label.centerXAnchor.constraint(equalTo: ev.contentView.centerXAnchor),
                label.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 8),
            ])

            self.effectView = ev
            stack.addArrangedSubview(glassContainer)

            // Buttons
            let buttonStack = UIStackView()
            buttonStack.axis = .horizontal
            buttonStack.spacing = 12
            buttonStack.distribution = .fillEqually

            let materializeButton = createActionButton(title: "Materialize", action: #selector(materialize))
            let dematerializeButton = createActionButton(title: "Dematerialize", action: #selector(dematerialize))
            let toggleButton = createActionButton(title: "Toggle", action: #selector(toggleGlass))

            buttonStack.addArrangedSubview(materializeButton)
            buttonStack.addArrangedSubview(dematerializeButton)
            buttonStack.addArrangedSubview(toggleButton)
            stack.addArrangedSubview(buttonStack)

            // Spring animation button
            let springButton = createActionButton(title: "Spring Animation", action: #selector(springAnimate))
            stack.addArrangedSubview(springButton)
        } else {
            stack.addArrangedSubview(createInfoLabel("Animated glass requires iOS 26.0+"))
        }

        statusLabel.text = "Glass: hidden"
        statusLabel.font = .preferredFont(forTextStyle: .footnote)
        statusLabel.textColor = .tertiaryLabel
        statusLabel.textAlignment = .center
        stack.addArrangedSubview(statusLabel)
    }

    @available(iOS 26.0, *)
    @objc private func materialize() {
        UIView.animate(withDuration: 0.5) {
            self.effectView?.effect = UIGlassEffect()
        }
        isGlassVisible = true
        statusLabel.text = "Glass: visible (materialized)"
    }

    @objc private func dematerialize() {
        UIView.animate(withDuration: 0.5) {
            self.effectView?.effect = nil
        }
        isGlassVisible = false
        statusLabel.text = "Glass: hidden (dematerialized)"
    }

    @available(iOS 26.0, *)
    @objc private func toggleGlass() {
        if isGlassVisible {
            dematerialize()
        } else {
            materialize()
        }
    }

    @available(iOS 26.0, *)
    @objc private func springAnimate() {
        if isGlassVisible {
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8) {
                self.effectView?.effect = nil
            }
            isGlassVisible = false
            statusLabel.text = "Glass: hidden (spring)"
        } else {
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8) {
                self.effectView?.effect = UIGlassEffect()
            }
            isGlassVisible = true
            statusLabel.text = "Glass: visible (spring)"
        }
    }

    private func createActionButton(title: String, action: Selector) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.cornerStyle = .medium
        config.buttonSize = .small
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
