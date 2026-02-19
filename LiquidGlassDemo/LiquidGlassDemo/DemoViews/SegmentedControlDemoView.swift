//
//  SegmentedControlDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class SegmentedControlDemoView: UIView {
    private let resultLabel = UILabel()

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
            "UISegmentedControl automatically adopts glass styling on iOS 26. The selected segment indicator uses a glass material."
        ))

        let standardSegment = UISegmentedControl(items: ["First", "Second", "Third"])
        standardSegment.selectedSegmentIndex = 0
        standardSegment.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        stack.addArrangedSubview(standardSegment)

        let imageSegment = UISegmentedControl(items: [
            UIImage(systemName: "list.bullet") as Any,
            UIImage(systemName: "square.grid.2x2") as Any,
            UIImage(systemName: "rectangle.grid.1x2") as Any,
        ])
        imageSegment.selectedSegmentIndex = 0
        imageSegment.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        stack.addArrangedSubview(imageSegment)

        let mixedSegment = UISegmentedControl(items: ["Day", "Week", "Month", "Year"])
        mixedSegment.selectedSegmentIndex = 1
        mixedSegment.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        stack.addArrangedSubview(mixedSegment)

        resultLabel.text = "Selected: First (index 0)"
        resultLabel.font = .preferredFont(forTextStyle: .footnote)
        resultLabel.textColor = .tertiaryLabel
        resultLabel.textAlignment = .center
        stack.addArrangedSubview(resultLabel)
    }

    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let title = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "Image"
        resultLabel.text = "Selected: \(title) (index \(sender.selectedSegmentIndex))"
    }
}
