//
//  TabBarDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class TabBarDemoView: UIView {

    private weak var parentVC: UIViewController?
    private let statusLabel = UILabel()

    init(parentVC: UIViewController) {
        self.parentVC = parentVC
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        let infoLabel = createInfoLabel(
            "The tab bar automatically adopts Liquid Glass when compiled with Xcode 26 SDK. Look at the bottom of the screen to see the glass tab bar.\n\nOn iOS 26, tab bars can minimize on scroll to give more room to content."
        )
        stack.addArrangedSubview(infoLabel)

        let minimizeButton = createActionButton(title: "Enable Minimize on Scroll", action: #selector(enableMinimize))
        let disableButton = createActionButton(title: "Disable Minimize on Scroll", action: #selector(disableMinimize))

        stack.addArrangedSubview(minimizeButton)
        stack.addArrangedSubview(disableButton)

        statusLabel.text = "Minimize behavior: default"
        statusLabel.font = .preferredFont(forTextStyle: .footnote)
        statusLabel.textColor = .tertiaryLabel
        statusLabel.textAlignment = .center
        stack.addArrangedSubview(statusLabel)

        // Add tall content to enable scrolling for minimize demo
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.heightAnchor.constraint(equalToConstant: 800).isActive = true
        stack.addArrangedSubview(spacer)

        let bottomLabel = UILabel()
        bottomLabel.text = "Scroll up to see tab bar minimize behavior"
        bottomLabel.font = .preferredFont(forTextStyle: .caption1)
        bottomLabel.textColor = .tertiaryLabel
        bottomLabel.textAlignment = .center
        stack.addArrangedSubview(bottomLabel)
    }

    @objc private func enableMinimize() {
        if #available(iOS 26.0, *) {
            parentVC?.tabBarController?.tabBarMinimizeBehavior = .onScrollDown
            statusLabel.text = "Minimize behavior: onScrollDown"
        }
    }

    @objc private func disableMinimize() {
        if #available(iOS 26.0, *) {
            parentVC?.tabBarController?.tabBarMinimizeBehavior = .never
            statusLabel.text = "Minimize behavior: never"
        }
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
