//
//  GlassEffectDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class GlassEffectDemoView: UIView {
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
            "Use UIVisualEffectView with UIGlassEffect to apply glass to custom views. Content is placed in the effect view's contentView."
        )
        stack.addArrangedSubview(infoLabel)

        if #available(iOS 26.0, *) {
            // Simple glass square
            let simpleGlass = createGlassView(size: CGSize(width: 120, height: 120), cornerRadius: 16)
            let simpleIcon = UIImageView(image: UIImage(systemName: "sparkles"))
            simpleIcon.tintColor = .label
            simpleIcon.contentMode = .scaleAspectFit
            simpleIcon.translatesAutoresizingMaskIntoConstraints = false
            simpleGlass.contentView.addSubview(simpleIcon)
            NSLayoutConstraint.activate([
                simpleIcon.centerXAnchor.constraint(equalTo: simpleGlass.contentView.centerXAnchor),
                simpleIcon.centerYAnchor.constraint(equalTo: simpleGlass.contentView.centerYAnchor),
                simpleIcon.widthAnchor.constraint(equalToConstant: 40),
                simpleIcon.heightAnchor.constraint(equalToConstant: 40),
            ])
            let simpleLabel = UILabel()
            simpleLabel.text = "Basic Glass (16pt radius)"
            simpleLabel.font = .preferredFont(forTextStyle: .caption1)
            simpleLabel.textColor = .secondaryLabel
            simpleLabel.textAlignment = .center
            stack.addArrangedSubview(simpleGlass)
            stack.addArrangedSubview(simpleLabel)

            // Glass with icon and text
            let cardGlass = createGlassView(size: CGSize(width: 280, height: 80), cornerRadius: 20)
            let cardStack = UIStackView()
            cardStack.axis = .horizontal
            cardStack.spacing = 12
            cardStack.alignment = .center
            cardStack.translatesAutoresizingMaskIntoConstraints = false

            let cardIcon = UIImageView(image: UIImage(systemName: "heart.fill"))
            cardIcon.tintColor = .systemPink
            cardIcon.contentMode = .scaleAspectFit
            cardIcon.translatesAutoresizingMaskIntoConstraints = false
            cardIcon.widthAnchor.constraint(equalToConstant: 32).isActive = true
            cardIcon.heightAnchor.constraint(equalToConstant: 32).isActive = true

            let cardTextStack = UIStackView()
            cardTextStack.axis = .vertical
            cardTextStack.spacing = 2
            let titleLabel = UILabel()
            titleLabel.text = "Glass Card"
            titleLabel.font = .preferredFont(forTextStyle: .headline)
            let subtitleLabel = UILabel()
            subtitleLabel.text = "Content inside UIGlassEffect"
            subtitleLabel.font = .preferredFont(forTextStyle: .caption1)
            subtitleLabel.textColor = .secondaryLabel
            cardTextStack.addArrangedSubview(titleLabel)
            cardTextStack.addArrangedSubview(subtitleLabel)

            cardStack.addArrangedSubview(cardIcon)
            cardStack.addArrangedSubview(cardTextStack)

            cardGlass.contentView.addSubview(cardStack)
            NSLayoutConstraint.activate([
                cardStack.leadingAnchor.constraint(equalTo: cardGlass.contentView.leadingAnchor, constant: 16),
                cardStack.trailingAnchor.constraint(equalTo: cardGlass.contentView.trailingAnchor, constant: -16),
                cardStack.centerYAnchor.constraint(equalTo: cardGlass.contentView.centerYAnchor),
            ])
            stack.addArrangedSubview(cardGlass)

            // Circular glass
            let circleGlass = createGlassView(size: CGSize(width: 80, height: 80), cornerRadius: 40)
            let circleIcon = UIImageView(image: UIImage(systemName: "person.fill"))
            circleIcon.tintColor = .label
            circleIcon.contentMode = .scaleAspectFit
            circleIcon.translatesAutoresizingMaskIntoConstraints = false
            circleGlass.contentView.addSubview(circleIcon)
            NSLayoutConstraint.activate([
                circleIcon.centerXAnchor.constraint(equalTo: circleGlass.contentView.centerXAnchor),
                circleIcon.centerYAnchor.constraint(equalTo: circleGlass.contentView.centerYAnchor),
                circleIcon.widthAnchor.constraint(equalToConstant: 32),
                circleIcon.heightAnchor.constraint(equalToConstant: 32),
            ])
            let circleLabel = UILabel()
            circleLabel.text = "Circular Glass"
            circleLabel.font = .preferredFont(forTextStyle: .caption1)
            circleLabel.textColor = .secondaryLabel
            circleLabel.textAlignment = .center
            stack.addArrangedSubview(circleGlass)
            stack.addArrangedSubview(circleLabel)
        } else {
            stack.addArrangedSubview(createInfoLabel("UIGlassEffect requires iOS 26.0+"))
        }
    }

    @available(iOS 26.0, *)
    private func createGlassView(size: CGSize, cornerRadius: CGFloat) -> UIVisualEffectView {
        let effect = UIGlassEffect()
        let effectView = UIVisualEffectView(effect: effect)
        effectView.cornerConfiguration = .capsule(maximumRadius: cornerRadius)
        effectView.translatesAutoresizingMaskIntoConstraints = false
        effectView.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        effectView.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return effectView
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
