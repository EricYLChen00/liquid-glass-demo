//
//  TabBarDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class TabBarDemoView: UIView {
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
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        let infoText = "The tab bar automatically adopts Liquid Glass "
            + "when compiled with Xcode 26 SDK. Look at the bottom "
            + "of the screen to see the glass tab bar."
        let infoLabel = UILabel()
        infoLabel.text = infoText
        infoLabel.font = .preferredFont(forTextStyle: .body)
        infoLabel.textColor = .secondaryLabel
        infoLabel.numberOfLines = 0
        stack.addArrangedSubview(infoLabel)
    }
}
