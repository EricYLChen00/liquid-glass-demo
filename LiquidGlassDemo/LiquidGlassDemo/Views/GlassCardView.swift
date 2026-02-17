//
//  GlassCardView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

@available(iOS 26.0, *)
class GlassCardView: UIView {
    private let effectView: UIVisualEffectView
    let contentContainerView = UIView()

    init(cornerRadius: CGFloat = 16) {
        let effect = UIGlassEffect()
        effectView = UIVisualEffectView(effect: effect)

        super.init(frame: .zero)

        effectView.cornerConfiguration = .capsule(maximumRadius: cornerRadius)
        effectView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(effectView)

        contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        effectView.contentView.addSubview(contentContainerView)

        NSLayoutConstraint.activate([
            effectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            effectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            effectView.topAnchor.constraint(equalTo: topAnchor),
            effectView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentContainerView.leadingAnchor.constraint(equalTo: effectView.contentView.leadingAnchor, constant: 16),
            contentContainerView.trailingAnchor.constraint(equalTo: effectView.contentView.trailingAnchor, constant: -16),
            contentContainerView.topAnchor.constraint(equalTo: effectView.contentView.topAnchor, constant: 12),
            contentContainerView.bottomAnchor.constraint(equalTo: effectView.contentView.bottomAnchor, constant: -12),
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
