//
//  GlassCardDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class GlassCardDemoView: UIView {

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
        stack.spacing = 20
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        let infoLabel = createInfoLabel(
            "A reusable GlassCardView component built with UIVisualEffectView + UIGlassEffect. Useful for building custom glass UI."
        )
        stack.addArrangedSubview(infoLabel)

        if #available(iOS 26.0, *) {
            // Card 1: Profile card
            let profileCard = GlassCardView(cornerRadius: 20)
            let profileStack = UIStackView()
            profileStack.axis = .horizontal
            profileStack.spacing = 12
            profileStack.alignment = .center
            profileStack.translatesAutoresizingMaskIntoConstraints = false

            let avatar = UIImageView(image: UIImage(systemName: "person.circle.fill"))
            avatar.tintColor = .systemBlue
            avatar.contentMode = .scaleAspectFit
            avatar.translatesAutoresizingMaskIntoConstraints = false
            avatar.widthAnchor.constraint(equalToConstant: 48).isActive = true
            avatar.heightAnchor.constraint(equalToConstant: 48).isActive = true

            let nameStack = UIStackView()
            nameStack.axis = .vertical
            nameStack.spacing = 2
            let nameLabel = UILabel()
            nameLabel.text = "John Appleseed"
            nameLabel.font = .preferredFont(forTextStyle: .headline)
            let roleLabel = UILabel()
            roleLabel.text = "iOS Developer"
            roleLabel.font = .preferredFont(forTextStyle: .subheadline)
            roleLabel.textColor = .secondaryLabel
            nameStack.addArrangedSubview(nameLabel)
            nameStack.addArrangedSubview(roleLabel)

            profileStack.addArrangedSubview(avatar)
            profileStack.addArrangedSubview(nameStack)
            profileCard.contentContainerView.addSubview(profileStack)
            NSLayoutConstraint.activate([
                profileStack.topAnchor.constraint(equalTo: profileCard.contentContainerView.topAnchor),
                profileStack.leadingAnchor.constraint(equalTo: profileCard.contentContainerView.leadingAnchor),
                profileStack.trailingAnchor.constraint(equalTo: profileCard.contentContainerView.trailingAnchor),
                profileStack.bottomAnchor.constraint(equalTo: profileCard.contentContainerView.bottomAnchor),
            ])
            stack.addArrangedSubview(profileCard)

            // Card 2: Info card
            let infoCard = GlassCardView(cornerRadius: 16)
            let infoStack = UIStackView()
            infoStack.axis = .vertical
            infoStack.spacing = 8
            infoStack.translatesAutoresizingMaskIntoConstraints = false

            let infoTitle = UILabel()
            infoTitle.text = "About Glass Cards"
            infoTitle.font = .preferredFont(forTextStyle: .headline)
            let infoBody = UILabel()
            infoBody.text = "Glass cards provide a beautiful translucent container that dynamically reflects and refracts the content behind them."
            infoBody.font = .preferredFont(forTextStyle: .body)
            infoBody.textColor = .secondaryLabel
            infoBody.numberOfLines = 0

            infoStack.addArrangedSubview(infoTitle)
            infoStack.addArrangedSubview(infoBody)
            infoCard.contentContainerView.addSubview(infoStack)
            NSLayoutConstraint.activate([
                infoStack.topAnchor.constraint(equalTo: infoCard.contentContainerView.topAnchor),
                infoStack.leadingAnchor.constraint(equalTo: infoCard.contentContainerView.leadingAnchor),
                infoStack.trailingAnchor.constraint(equalTo: infoCard.contentContainerView.trailingAnchor),
                infoStack.bottomAnchor.constraint(equalTo: infoCard.contentContainerView.bottomAnchor),
            ])
            stack.addArrangedSubview(infoCard)

            // Card 3: Stats card
            let statsCard = GlassCardView(cornerRadius: 24)
            let statsStack = UIStackView()
            statsStack.axis = .horizontal
            statsStack.distribution = .equalSpacing
            statsStack.translatesAutoresizingMaskIntoConstraints = false

            let stats = [("42", "Posts"), ("1.2K", "Likes"), ("89", "Following")]
            for (value, label) in stats {
                let statStack = UIStackView()
                statStack.axis = .vertical
                statStack.alignment = .center
                statStack.spacing = 2
                let valueLabel = UILabel()
                valueLabel.text = value
                valueLabel.font = .preferredFont(forTextStyle: .title2)
                let titleLabel = UILabel()
                titleLabel.text = label
                titleLabel.font = .preferredFont(forTextStyle: .caption1)
                titleLabel.textColor = .secondaryLabel
                statStack.addArrangedSubview(valueLabel)
                statStack.addArrangedSubview(titleLabel)
                statsStack.addArrangedSubview(statStack)
            }

            statsCard.contentContainerView.addSubview(statsStack)
            NSLayoutConstraint.activate([
                statsStack.topAnchor.constraint(equalTo: statsCard.contentContainerView.topAnchor),
                statsStack.leadingAnchor.constraint(equalTo: statsCard.contentContainerView.leadingAnchor),
                statsStack.trailingAnchor.constraint(equalTo: statsCard.contentContainerView.trailingAnchor),
                statsStack.bottomAnchor.constraint(equalTo: statsCard.contentContainerView.bottomAnchor),
            ])
            stack.addArrangedSubview(statsCard)
        } else {
            stack.addArrangedSubview(createInfoLabel("GlassCardView requires iOS 26.0+"))
        }
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
