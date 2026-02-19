//
//  DatePickerDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class DatePickerDemoView: UIView {
    private let resultLabel = UILabel()
    private let datePicker = UIDatePicker()
    private let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .short
        return f
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let stack = addPinnedStack(spacing: 20)

        stack.addArrangedSubview(DemoUI.infoLabel(
            "UIDatePicker with glass styling on iOS 26. Switch between styles to see different presentations."
        ))

        let styleSegment = UISegmentedControl(items: ["Automatic", "Compact", "Inline", "Wheels"])
        styleSegment.selectedSegmentIndex = 0
        styleSegment.addTarget(self, action: #selector(styleChanged(_:)), for: .valueChanged)
        stack.addArrangedSubview(styleSegment)

        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        stack.addArrangedSubview(datePicker)

        resultLabel.text = "Selected: \(dateFormatter.string(from: datePicker.date))"
        resultLabel.font = .preferredFont(forTextStyle: .footnote)
        resultLabel.textColor = .tertiaryLabel
        resultLabel.textAlignment = .center
        stack.addArrangedSubview(resultLabel)
    }

    @objc private func styleChanged(_ sender: UISegmentedControl) {
        let styles: [UIDatePickerStyle] = [.automatic, .compact, .inline, .wheels]
        datePicker.preferredDatePickerStyle = styles[sender.selectedSegmentIndex]
    }

    @objc private func dateChanged(_ sender: UIDatePicker) {
        resultLabel.text = "Selected: \(dateFormatter.string(from: sender.date))"
    }
}
