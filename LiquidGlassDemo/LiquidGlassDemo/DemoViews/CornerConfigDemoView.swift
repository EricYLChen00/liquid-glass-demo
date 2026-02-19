//
//  CornerConfigDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class CornerConfigDemoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let stack = addPinnedStack(spacing: 24, alignment: .center)

        stack.addArrangedSubview(DemoUI.infoLabel(
            "iOS 26 introduces cornerConfiguration on UIView for glass effects. Different corner radius values create different shapes."
        ))

        if #available(iOS 26.0, *) {
            stack.addArrangedSubview(createGlassWithLabel(
                size: CGSize(width: 200, height: 80),
                cornerRadius: 16,
                label: "Rounded Rect (16pt)"
            ))
            stack.addArrangedSubview(createGlassWithLabel(
                size: CGSize(width: 200, height: 60),
                cornerRadius: 30,
                label: "Capsule (height/2)"
            ))
            stack.addArrangedSubview(createGlassWithLabel(
                size: CGSize(width: 100, height: 100),
                cornerRadius: 50,
                label: "Circle"
            ))
            stack.addArrangedSubview(createGlassWithLabel(
                size: CGSize(width: 280, height: 120),
                cornerRadius: 32,
                label: "Large Rounded (32pt)"
            ))
            stack.addArrangedSubview(createGlassWithLabel(
                size: CGSize(width: 160, height: 60),
                cornerRadius: 8,
                label: "Subtle Rounded (8pt)"
            ))
        } else {
            stack.addArrangedSubview(DemoUI.infoLabel("Corner configuration requires iOS 26.0+"))
        }
    }

    @available(iOS 26.0, *)
    private func createGlassWithLabel(size: CGSize, cornerRadius: CGFloat, label text: String) -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 6
        container.alignment = .center

        let effect = UIGlassEffect()
        let effectView = UIVisualEffectView(effect: effect)
        effectView.cornerConfiguration = .capsule(maximumRadius: cornerRadius)
        effectView.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = text
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        effectView.contentView.addSubview(label)

        NSLayoutConstraint.activate([
            effectView.widthAnchor.constraint(equalToConstant: size.width),
            effectView.heightAnchor.constraint(equalToConstant: size.height),
            label.centerXAnchor.constraint(equalTo: effectView.contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: effectView.contentView.centerYAnchor),
        ])

        let captionLabel = UILabel()
        captionLabel.text = "cornerRadius: \(Int(cornerRadius))"
        captionLabel.font = .preferredFont(forTextStyle: .caption2)
        captionLabel.textColor = .tertiaryLabel

        container.addArrangedSubview(effectView)
        container.addArrangedSubview(captionLabel)
        return container
    }
}
