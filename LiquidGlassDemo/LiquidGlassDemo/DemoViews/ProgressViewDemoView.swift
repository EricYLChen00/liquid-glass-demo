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

    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if newWindow == nil { timer?.invalidate() }
    }

    private func setupUI() {
        let stack = addPinnedStack(spacing: 24)

        stack.addArrangedSubview(DemoUI.infoLabel(
            "UIProgressView on iOS 26 with updated styling. Tap Start to see animated progress."
        ))

        stack.addArrangedSubview(DemoUI.sectionLabel("Default Style"))
        progressView.progress = 0
        stack.addArrangedSubview(progressView)

        stack.addArrangedSubview(DemoUI.sectionLabel("Bar Style"))
        barProgressView.progress = 0
        stack.addArrangedSubview(barProgressView)

        stack.addArrangedSubview(DemoUI.sectionLabel("Tinted Progress"))
        let tintedProgress = UIProgressView(progressViewStyle: .default)
        tintedProgress.progressTintColor = .systemGreen
        tintedProgress.trackTintColor = .systemGreen.withAlphaComponent(0.2)
        tintedProgress.progress = 0.65
        stack.addArrangedSubview(tintedProgress)

        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.spacing = 12
        buttonStack.distribution = .fillEqually
        buttonStack.addArrangedSubview(DemoUI.actionButton(title: "Start", target: self, action: #selector(startProgress)))
        buttonStack.addArrangedSubview(DemoUI.actionButton(title: "Reset", target: self, action: #selector(resetProgress)))
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
}
