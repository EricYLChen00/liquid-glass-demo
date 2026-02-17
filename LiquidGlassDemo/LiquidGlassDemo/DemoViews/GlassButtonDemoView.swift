//
//  GlassButtonDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class GlassButtonDemoView: UIView {
    private let resultLabel = UILabel()
    private var tapCount = 0

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
            "UIButton with .glass() configuration provides a standard glass button style. These buttons have a translucent glass background."
        )
        infoLabel.textAlignment = .natural
        stack.addArrangedSubview(infoLabel)

        if #available(iOS 26.0, *) {
            // Simple glass button
            let simpleButton = UIButton(configuration: .glass())
            simpleButton.setTitle("Glass Button", for: .normal)
            simpleButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            stack.addArrangedSubview(simpleButton)

            // Glass button with icon
            var iconConfig = UIButton.Configuration.glass()
            iconConfig.image = UIImage(systemName: "heart.fill")
            iconConfig.title = "Like"
            iconConfig.imagePadding = 8
            let iconButton = UIButton(configuration: iconConfig)
            iconButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            stack.addArrangedSubview(iconButton)

            // Glass button with subtitle
            var subtitleConfig = UIButton.Configuration.glass()
            subtitleConfig.title = "Download"
            subtitleConfig.subtitle = "4.2 MB"
            subtitleConfig.image = UIImage(systemName: "arrow.down.circle")
            subtitleConfig.imagePadding = 8
            let subtitleButton = UIButton(configuration: subtitleConfig)
            subtitleButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            stack.addArrangedSubview(subtitleButton)

            // Large glass button
            var largeConfig = UIButton.Configuration.glass()
            largeConfig.title = "Large Glass Button"
            largeConfig.buttonSize = .large
            let largeButton = UIButton(configuration: largeConfig)
            largeButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            stack.addArrangedSubview(largeButton)

            // Small glass button
            var smallConfig = UIButton.Configuration.glass()
            smallConfig.title = "Small"
            smallConfig.buttonSize = .small
            let smallButton = UIButton(configuration: smallConfig)
            smallButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            stack.addArrangedSubview(smallButton)
        } else {
            stack.addArrangedSubview(createInfoLabel("Glass buttons require iOS 26.0+"))
        }

        resultLabel.text = "Tap any button"
        resultLabel.font = .preferredFont(forTextStyle: .footnote)
        resultLabel.textColor = .tertiaryLabel
        resultLabel.textAlignment = .center
        stack.addArrangedSubview(resultLabel)
    }

    @objc private func buttonTapped() {
        tapCount += 1
        resultLabel.text = "Button tapped \(tapCount) time\(tapCount == 1 ? "" : "s")"
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
