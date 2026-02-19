//
//  TintedGlassDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class TintedGlassDemoView: UIView {
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
            "Tinted glass adds a color overlay to convey "
            + "semantic meaning. In UIKit, add a background color "
            + "view inside the effect view's contentView."
        ))

        if #available(iOS 26.0, *) {
            let colors: [(UIColor, String)] = [
                (.systemRed, "Red Tint"),
                (.systemBlue, "Blue Tint"),
                (.systemGreen, "Green Tint"),
                (.systemPurple, "Purple Tint"),
                (.systemOrange, "Orange Tint"),
                (.systemCyan, "Cyan Tint"),
            ]

            let gridStack = UIStackView()
            gridStack.axis = .vertical
            gridStack.spacing = 12
            gridStack.alignment = .center

            for rowStart in stride(from: 0, to: colors.count, by: 3) {
                let rowStack = UIStackView()
                rowStack.axis = .horizontal
                rowStack.spacing = 12
                rowStack.alignment = .center

                let rowEnd = min(rowStart + 3, colors.count)
                for i in rowStart..<rowEnd {
                    let (color, name) = colors[i]
                    let itemStack = UIStackView()
                    itemStack.axis = .vertical
                    itemStack.spacing = 4
                    itemStack.alignment = .center

                    let glassView = createTintedGlassView(tintColor: color, size: CGSize(width: 90, height: 90))
                    let label = UILabel()
                    label.text = name
                    label.font = .preferredFont(forTextStyle: .caption2)
                    label.textColor = .secondaryLabel

                    itemStack.addArrangedSubview(glassView)
                    itemStack.addArrangedSubview(label)
                    rowStack.addArrangedSubview(itemStack)
                }
                gridStack.addArrangedSubview(rowStack)
            }

            stack.addArrangedSubview(gridStack)

            let wideGlass = createTintedGlassView(tintColor: .systemIndigo, size: CGSize(width: 300, height: 60))
            let barLabel = UILabel()
            barLabel.text = "Tinted Glass Bar"
            barLabel.font = .preferredFont(forTextStyle: .headline)
            barLabel.textColor = .label
            barLabel.translatesAutoresizingMaskIntoConstraints = false
            wideGlass.contentView.addSubview(barLabel)
            NSLayoutConstraint.activate([
                barLabel.centerXAnchor.constraint(equalTo: wideGlass.contentView.centerXAnchor),
                barLabel.centerYAnchor.constraint(equalTo: wideGlass.contentView.centerYAnchor),
            ])
            stack.addArrangedSubview(wideGlass)
        } else {
            stack.addArrangedSubview(DemoUI.infoLabel("Tinted glass requires iOS 26.0+"))
        }
    }

    @available(iOS 26.0, *)
    private func createTintedGlassView(tintColor: UIColor, size: CGSize) -> UIVisualEffectView {
        let effect = UIGlassEffect()
        let effectView = UIVisualEffectView(effect: effect)
        effectView.cornerConfiguration = .capsule(maximumRadius: 16)
        effectView.translatesAutoresizingMaskIntoConstraints = false

        let tintView = UIView()
        tintView.backgroundColor = tintColor.withAlphaComponent(0.3)
        tintView.translatesAutoresizingMaskIntoConstraints = false
        effectView.contentView.insertSubview(tintView, at: 0)

        NSLayoutConstraint.activate([
            effectView.widthAnchor.constraint(equalToConstant: size.width),
            effectView.heightAnchor.constraint(equalToConstant: size.height),
            tintView.leadingAnchor.constraint(equalTo: effectView.contentView.leadingAnchor),
            tintView.trailingAnchor.constraint(equalTo: effectView.contentView.trailingAnchor),
            tintView.topAnchor.constraint(equalTo: effectView.contentView.topAnchor),
            tintView.bottomAnchor.constraint(equalTo: effectView.contentView.bottomAnchor),
        ])

        return effectView
    }
}
