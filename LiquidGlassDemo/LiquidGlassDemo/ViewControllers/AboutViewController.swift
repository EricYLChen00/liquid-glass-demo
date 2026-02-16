//
//  AboutViewController.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "About"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        setupUI()
    }

    private func setupUI() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        let iconImage = UIImageView(image: UIImage(systemName: "drop.fill"))
        iconImage.tintColor = .systemCyan
        iconImage.contentMode = .scaleAspectFit
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 60).isActive = true

        let titleLabel = UILabel()
        titleLabel.text = "Liquid Glass Demo"
        titleLabel.font = .preferredFont(forTextStyle: .title1)
        titleLabel.textAlignment = .center

        let versionLabel = UILabel()
        versionLabel.text = "iOS 26+ | UIKit"
        versionLabel.font = .preferredFont(forTextStyle: .subheadline)
        versionLabel.textColor = .secondaryLabel
        versionLabel.textAlignment = .center

        let descriptionLabel = UILabel()
        descriptionLabel.text = "A showcase of all Liquid Glass components available in iOS 26. This app demonstrates how standard UIKit components automatically adopt the new glass material, and how to create custom glass effects using UIGlassEffect and UIGlassContainerEffect."
        descriptionLabel.font = .preferredFont(forTextStyle: .body)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0

        let referenceLabel = UILabel()
        referenceLabel.text = "Reference: developer.apple.com/documentation/technologyoverviews/adopting-liquid-glass"
        referenceLabel.font = .preferredFont(forTextStyle: .caption1)
        referenceLabel.textColor = .tertiaryLabel
        referenceLabel.textAlignment = .center
        referenceLabel.numberOfLines = 0

        stack.addArrangedSubview(iconImage)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(versionLabel)
        stack.addArrangedSubview(descriptionLabel)
        stack.addArrangedSubview(referenceLabel)

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
    }
}
