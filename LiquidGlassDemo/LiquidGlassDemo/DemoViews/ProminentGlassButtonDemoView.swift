//
//  ProminentGlassButtonDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class ProminentGlassButtonDemoView: UIView {
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
        let stack = addPinnedStack(spacing: 20, alignment: .center)

        let infoLabel = DemoUI.infoLabel(
            "UIButton with .prominentGlass() provides a more visually prominent glass style, ideal for primary actions."
        )
        infoLabel.textAlignment = .natural
        stack.addArrangedSubview(infoLabel)

        if #available(iOS 26.0, *) {
            let prominentButton = UIButton(configuration: .prominentGlass())
            prominentButton.setTitle("Prominent Glass", for: .normal)
            prominentButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            stack.addArrangedSubview(prominentButton)

            var iconConfig = UIButton.Configuration.prominentGlass()
            iconConfig.image = UIImage(systemName: "plus")
            iconConfig.title = "Add Item"
            iconConfig.imagePadding = 8
            let iconButton = UIButton(configuration: iconConfig)
            iconButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            stack.addArrangedSubview(iconButton)

            var tintedConfig = UIButton.Configuration.prominentGlass()
            tintedConfig.title = "Tinted Prominent"
            tintedConfig.baseForegroundColor = .systemRed
            let tintedButton = UIButton(configuration: tintedConfig)
            tintedButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            stack.addArrangedSubview(tintedButton)

            var largeConfig = UIButton.Configuration.prominentGlass()
            largeConfig.title = "Confirm Action"
            largeConfig.buttonSize = .large
            largeConfig.image = UIImage(systemName: "checkmark")
            largeConfig.imagePadding = 8
            let largeButton = UIButton(configuration: largeConfig)
            largeButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            stack.addArrangedSubview(largeButton)
        } else {
            stack.addArrangedSubview(DemoUI.infoLabel("Prominent glass buttons require iOS 26.0+"))
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
}
