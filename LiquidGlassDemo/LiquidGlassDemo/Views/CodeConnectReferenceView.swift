//
//  CodeConnectReferenceView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class CodeConnectReferenceView: UIView {
    private let info: CodeConnectInfo

    init(info: CodeConnectInfo) {
        self.info = info
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let card = UIView()
        card.backgroundColor = .secondarySystemGroupedBackground
        card.layer.cornerRadius = 12
        card.clipsToBounds = true
        card.translatesAutoresizingMaskIntoConstraints = false
        addSubview(card)

        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: topAnchor),
            card.leadingAnchor.constraint(equalTo: leadingAnchor),
            card.trailingAnchor.constraint(equalTo: trailingAnchor),
            card.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(
                equalTo: card.topAnchor, constant: 16
            ),
            stack.leadingAnchor.constraint(
                equalTo: card.leadingAnchor, constant: 16
            ),
            stack.trailingAnchor.constraint(
                equalTo: card.trailingAnchor, constant: -16
            ),
            stack.bottomAnchor.constraint(
                equalTo: card.bottomAnchor, constant: -16
            ),
        ])

        // Title
        let titleLabel = UILabel()
        titleLabel.text = "Code Connect Reference"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        stack.addArrangedSubview(titleLabel)

        // Separator
        stack.addArrangedSubview(makeSeparator())

        // UIKit section
        stack.addArrangedSubview(
            makeCodeSection(title: "UIKit", code: info.uikitCode)
        )

        // SwiftUI section
        stack.addArrangedSubview(
            makeCodeSection(title: "SwiftUI", code: info.swiftuiCode)
        )
    }

    private func makeCodeSection(
        title: String,
        code: String
    ) -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 8

        let label = UILabel()
        label.text = title
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        container.addArrangedSubview(label)

        let codeBackground = UIView()
        codeBackground.backgroundColor = .tertiarySystemGroupedBackground
        codeBackground.layer.cornerRadius = 8

        let codeLabel = UILabel()
        codeLabel.text = code
        codeLabel.font = .monospacedSystemFont(
            ofSize: 13, weight: .regular
        )
        codeLabel.textColor = .label
        codeLabel.numberOfLines = 0
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        codeBackground.addSubview(codeLabel)

        NSLayoutConstraint.activate([
            codeLabel.topAnchor.constraint(
                equalTo: codeBackground.topAnchor, constant: 10
            ),
            codeLabel.leadingAnchor.constraint(
                equalTo: codeBackground.leadingAnchor, constant: 12
            ),
            codeLabel.trailingAnchor.constraint(
                equalTo: codeBackground.trailingAnchor, constant: -12
            ),
            codeLabel.bottomAnchor.constraint(
                equalTo: codeBackground.bottomAnchor, constant: -10
            ),
        ])

        container.addArrangedSubview(codeBackground)
        return container
    }

    private func makeSeparator() -> UIView {
        let sep = UIView()
        sep.backgroundColor = .separator
        sep.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return sep
    }
}
