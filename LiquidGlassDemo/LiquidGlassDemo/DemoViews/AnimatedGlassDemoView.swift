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
        let stack = addPinnedStack(spacing: 24, alignment: .center)

        stack.addArrangedSubview(DemoUI.infoLabel(
            "Animate glass materialization and dematerialization by toggling the UIVisualEffectView's effect property inside UIView.animate."
        ))

        if #available(iOS 26.0, *) {
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

            let buttonStack = UIStackView()
            buttonStack.axis = .horizontal
            buttonStack.spacing = 12
            buttonStack.distribution = .fillEqually
            buttonStack.addArrangedSubview(DemoUI.actionButton(title: "Materialize", target: self, action: #selector(materialize), size: .small))
            buttonStack.addArrangedSubview(DemoUI.actionButton(title: "Dematerialize", target: self, action: #selector(dematerialize), size: .small))
            buttonStack.addArrangedSubview(DemoUI.actionButton(title: "Toggle", target: self, action: #selector(toggleGlass), size: .small))
            stack.addArrangedSubview(buttonStack)

            stack.addArrangedSubview(DemoUI.actionButton(title: "Spring Animation", target: self, action: #selector(springAnimate), size: .small))
        } else {
            stack.addArrangedSubview(DemoUI.infoLabel("Animated glass requires iOS 26.0+"))
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
}
