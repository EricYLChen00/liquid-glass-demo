//
//  SFSymbolsDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class SFSymbolsDemoView: UIView {
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

        stack.addArrangedSubview(DemoUI.infoLabel(
            "On iOS 26, toolbar icons should use plain "
            + "SF Symbol variants (no circle/square fill "
            + "backgrounds) since the glass effect provides "
            + "the container."
        ))

        if #available(iOS 26.0, *) {
            let symbols = [
                "heart", "star", "bell", "bookmark",
                "gear", "person", "house", "magnifyingglass",
                "camera", "photo", "pencil", "trash",
                "folder", "paperplane", "link", "lock",
            ]

            let gridStack = UIStackView()
            gridStack.axis = .vertical
            gridStack.spacing = 12
            gridStack.alignment = .center

            for rowStart in stride(from: 0, to: symbols.count, by: 4) {
                let rowStack = UIStackView()
                rowStack.axis = .horizontal
                rowStack.spacing = 12
                rowStack.alignment = .center

                let rowEnd = min(rowStart + 4, symbols.count)
                for i in rowStart..<rowEnd {
                    let symbolName = symbols[i]
                    let glassIcon = createGlassIcon(systemName: symbolName)
                    rowStack.addArrangedSubview(glassIcon)
                }
                gridStack.addArrangedSubview(rowStack)
            }

            stack.addArrangedSubview(gridStack)
        } else {
            stack.addArrangedSubview(DemoUI.infoLabel("SF Symbols on glass requires iOS 26.0+"))
        }

        let resultLabel = UILabel()
        resultLabel.text = "Plain SF Symbol variants on glass circles"
        resultLabel.font = .preferredFont(forTextStyle: .footnote)
        resultLabel.textColor = .tertiaryLabel
        resultLabel.textAlignment = .center
        stack.addArrangedSubview(resultLabel)
    }

    @available(iOS 26.0, *)
    private func createGlassIcon(systemName: String) -> UIView {
        let effect = UIGlassEffect()
        let effectView = UIVisualEffectView(effect: effect)
        effectView.cornerConfiguration = .capsule(maximumRadius: 22)
        effectView.translatesAutoresizingMaskIntoConstraints = false

        let icon = UIImageView(image: UIImage(systemName: systemName))
        icon.tintColor = .label
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        effectView.contentView.addSubview(icon)

        NSLayoutConstraint.activate([
            effectView.widthAnchor.constraint(equalToConstant: 44),
            effectView.heightAnchor.constraint(equalToConstant: 44),
            icon.centerXAnchor.constraint(equalTo: effectView.contentView.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: effectView.contentView.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 22),
            icon.heightAnchor.constraint(equalToConstant: 22),
        ])

        return effectView
    }
}
