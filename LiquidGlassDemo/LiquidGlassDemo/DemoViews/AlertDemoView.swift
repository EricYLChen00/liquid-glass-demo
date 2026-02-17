//
//  AlertDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class AlertDemoView: UIView {
    private weak var parentVC: UIViewController?
    private let resultLabel = UILabel()

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
            "Alerts and action sheets automatically adopt Liquid Glass styling on iOS 26. Tap the buttons below to see them."
        )
        stack.addArrangedSubview(infoLabel)

        let alertButton = createActionButton(title: "Show Alert", action: #selector(showAlert))
        let alertWithTextFieldButton = createActionButton(title: "Show Alert with Text Field", action: #selector(showAlertWithTextField))
        let actionSheetButton = createActionButton(title: "Show Action Sheet", action: #selector(showActionSheet))

        stack.addArrangedSubview(alertButton)
        stack.addArrangedSubview(alertWithTextFieldButton)
        stack.addArrangedSubview(actionSheetButton)

        resultLabel.text = "Tap a button to show glass-styled alerts"
        resultLabel.font = .preferredFont(forTextStyle: .footnote)
        resultLabel.textColor = .tertiaryLabel
        resultLabel.textAlignment = .center
        stack.addArrangedSubview(resultLabel)
    }

    @objc private func showAlert() {
        let alert = UIAlertController(
            title: "Liquid Glass Alert",
            message: "This alert uses Liquid Glass styling on iOS 26.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.resultLabel.text = "Cancelled"
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.resultLabel.text = "OK tapped"
        })
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.resultLabel.text = "Delete tapped"
        })
        parentVC?.present(alert, animated: true)
    }

    @objc private func showAlertWithTextField() {
        let alert = UIAlertController(
            title: "Input",
            message: "Enter something to see glass-styled text field.",
            preferredStyle: .alert
        )
        alert.addTextField { textField in
            textField.placeholder = "Type here..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Submit", style: .default) { [weak self] _ in
            let text = alert.textFields?.first?.text ?? ""
            self?.resultLabel.text = "Submitted: \"\(text)\""
        })
        parentVC?.present(alert, animated: true)
    }

    @objc private func showActionSheet() {
        let sheet = UIAlertController(
            title: "Liquid Glass Action Sheet",
            message: "Choose an option",
            preferredStyle: .actionSheet
        )
        sheet.addAction(UIAlertAction(title: "Share", style: .default) { [weak self] _ in
            self?.resultLabel.text = "Share selected"
        })
        sheet.addAction(UIAlertAction(title: "Copy", style: .default) { [weak self] _ in
            self?.resultLabel.text = "Copy selected"
        })
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.resultLabel.text = "Delete selected"
        })
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        parentVC?.present(sheet, animated: true)
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
