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
        let stack = addPinnedStack()

        stack.addArrangedSubview(DemoUI.infoLabel(
            "Alerts and action sheets automatically adopt Liquid Glass styling on iOS 26. Tap the buttons below to see them."
        ))
        stack.addArrangedSubview(DemoUI.actionButton(title: "Show Alert", target: self, action: #selector(showAlert)))
        stack.addArrangedSubview(DemoUI.actionButton(title: "Show Alert with Text Field", target: self, action: #selector(showAlertWithTextField)))
        stack.addArrangedSubview(DemoUI.actionButton(title: "Show Action Sheet", target: self, action: #selector(showActionSheet)))

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
}
