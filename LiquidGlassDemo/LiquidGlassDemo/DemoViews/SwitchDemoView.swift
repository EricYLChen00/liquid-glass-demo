//
//  SwitchDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class SwitchDemoView: UIView {
    private let statusLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let stack = addPinnedStack(spacing: 24)

        stack.addArrangedSubview(DemoUI.infoLabel(
            "UISwitch on iOS 26 features an updated glass appearance. Toggle the switches to see the animation."
        ))

        let switches: [(String, UIColor?, Bool)] = [
            ("Wi-Fi", nil, true),
            ("Bluetooth", nil, false),
            ("Airplane Mode", .systemOrange, false),
            ("Do Not Disturb", .systemPurple, true),
            ("Dark Mode", nil, false),
        ]

        for (title, color, isOn) in switches {
            let row = createSwitchRow(title: title, tintColor: color, isOn: isOn)
            stack.addArrangedSubview(row)
        }

        statusLabel.text = "Toggle any switch"
        statusLabel.font = .preferredFont(forTextStyle: .footnote)
        statusLabel.textColor = .tertiaryLabel
        statusLabel.textAlignment = .center
        stack.addArrangedSubview(statusLabel)
    }

    private func createSwitchRow(title: String, tintColor: UIColor?, isOn: Bool) -> UIView {
        let row = UIStackView()
        row.axis = .horizontal
        row.alignment = .center
        row.distribution = .fill

        let label = UILabel()
        label.text = title
        label.font = .preferredFont(forTextStyle: .body)

        let toggle = UISwitch()
        toggle.isOn = isOn
        toggle.accessibilityLabel = title
        if let tintColor {
            toggle.onTintColor = tintColor
        }
        toggle.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)

        row.addArrangedSubview(label)
        row.addArrangedSubview(toggle)

        return row
    }

    @objc private func switchToggled(_ sender: UISwitch) {
        let state = sender.isOn ? "ON" : "OFF"
        let name = sender.accessibilityLabel ?? "Switch"
        statusLabel.text = "\(name): \(state)"
    }
}
