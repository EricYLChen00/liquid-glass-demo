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
        let stack = addPinnedStack()

        stack.addArrangedSubview(DemoUI.infoLabel(
            "The navigation bar automatically adopts "
            + "Liquid Glass when compiled with Xcode 26 SDK. "
            + "No code changes needed.\n\nTap buttons below to "
            + "configure different bar button item styles."
        ))

        stack.addArrangedSubview(DemoUI.actionButton(title: "Default Style", target: self, action: #selector(applyDefaultStyle)))
        stack.addArrangedSubview(DemoUI.actionButton(title: "Prominent Bar Items", target: self, action: #selector(applyProminentStyle)))
        stack.addArrangedSubview(DemoUI.actionButton(title: "Fixed Space Layout", target: self, action: #selector(applyFixedSpaceStyle)))
        stack.addArrangedSubview(DemoUI.actionButton(title: "Reset", target: self, action: #selector(resetStyle)))
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
}
