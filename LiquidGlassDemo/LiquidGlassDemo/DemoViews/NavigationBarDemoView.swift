//
//  NavigationBarDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class NavigationBarDemoView: UIView {

    private weak var parentVC: UIViewController?

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
            "The navigation bar automatically adopts Liquid Glass when compiled with Xcode 26 SDK. No code changes needed.\n\nTap buttons below to configure different bar button item styles."
        )
        stack.addArrangedSubview(infoLabel)

        let defaultButton = createActionButton(title: "Default Style", action: #selector(applyDefaultStyle))
        let prominentButton = createActionButton(title: "Prominent Bar Items", action: #selector(applyProminentStyle))
        let fixedSpaceButton = createActionButton(title: "Fixed Space Layout", action: #selector(applyFixedSpaceStyle))
        let resetButton = createActionButton(title: "Reset", action: #selector(resetStyle))

        stack.addArrangedSubview(defaultButton)
        stack.addArrangedSubview(prominentButton)
        stack.addArrangedSubview(fixedSpaceButton)
        stack.addArrangedSubview(resetButton)
    }

    @objc private func applyDefaultStyle() {
        parentVC?.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: nil, action: nil),
        ]
    }

    @objc private func applyProminentStyle() {
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: nil, action: nil)
        let flagButton = UIBarButtonItem(image: UIImage(systemName: "flag.fill"), style: .plain, target: nil, action: nil)
        flagButton.tintColor = .systemOrange
        parentVC?.navigationItem.rightBarButtonItems = [doneButton, flagButton]
    }

    @objc private func applyFixedSpaceStyle() {
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: nil, action: nil)
        let fixedSpace = UIBarButtonItem.fixedSpace(0)
        let bookmarkButton = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: nil, action: nil)
        parentVC?.navigationItem.rightBarButtonItems = [shareButton, fixedSpace, bookmarkButton]
    }

    @objc private func resetStyle() {
        parentVC?.navigationItem.rightBarButtonItems = nil
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
