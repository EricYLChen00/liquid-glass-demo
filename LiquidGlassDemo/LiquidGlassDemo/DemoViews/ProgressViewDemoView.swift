//
//  ProgressViewDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class ProgressViewDemoView: UIView {

    private let progressView = UIProgressView(progressViewStyle: .default)
    private let barProgressView = UIProgressView(progressViewStyle: .bar)
    private let statusLabel = UILabel()
    private var timer: Timer?

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
        stack.spacing = 24
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
            "UIProgressView on iOS 26 with updated styling. Tap Start to see animated progress."
        )
        stack.addArrangedSubview(infoLabel)

        // Default style
        let sectionLabel1 = createSectionLabel("Default Style")
        stack.addArrangedSubview(sectionLabel1)

        progressView.progress = 0
        stack.addArrangedSubview(progressView)

        // Bar style
        let sectionLabel2 = createSectionLabel("Bar Style")
        stack.addArrangedSubview(sectionLabel2)

        barProgressView.progress = 0
        stack.addArrangedSubview(barProgressView)

        // Tinted progress
        let sectionLabel3 = createSectionLabel("Tinted Progress")
        stack.addArrangedSubview(sectionLabel3)

        let tintedProgress = UIProgressView(progressViewStyle: .default)
        tintedProgress.progressTintColor = .systemGreen
        tintedProgress.trackTintColor = .systemGreen.withAlphaComponent(0.2)
        tintedProgress.progress = 0.65
        stack.addArrangedSubview(tintedProgress)

        // Buttons
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.spacing = 12
        buttonStack.distribution = .fillEqually

        let startButton = createActionButton(title: "Start", action: #selector(startProgress))
        let resetButton = createActionButton(title: "Reset", action: #selector(resetProgress))

        buttonStack.addArrangedSubview(startButton)
        buttonStack.addArrangedSubview(resetButton)
        stack.addArrangedSubview(buttonStack)

        statusLabel.text = "Progress: 0%"
        statusLabel.font = .preferredFont(forTextStyle: .footnote)
        statusLabel.textColor = .tertiaryLabel
        statusLabel.textAlignment = .center
        stack.addArrangedSubview(statusLabel)
    }

    @objc private func startProgress() {
        timer?.invalidate()
        progressView.progress = 0
        barProgressView.progress = 0

        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] timer in
            guard let self else {
                timer.invalidate()
                return
            }
            let newProgress = self.progressView.progress + 0.01
            if newProgress >= 1.0 {
                self.progressView.setProgress(1.0, animated: true)
                self.barProgressView.setProgress(1.0, animated: true)
                self.statusLabel.text = "Progress: 100% - Complete!"
                timer.invalidate()
            } else {
                self.progressView.setProgress(newProgress, animated: true)
                self.barProgressView.setProgress(newProgress, animated: true)
                self.statusLabel.text = String(format: "Progress: %.0f%%", newProgress * 100)
            }
        }
    }

    @objc private func resetProgress() {
        timer?.invalidate()
        progressView.setProgress(0, animated: true)
        barProgressView.setProgress(0, animated: true)
        statusLabel.text = "Progress: 0%"
    }

    private func createSectionLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .label
        return label
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
