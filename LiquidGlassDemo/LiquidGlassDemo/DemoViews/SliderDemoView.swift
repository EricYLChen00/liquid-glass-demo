//
//  SliderDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class SliderDemoView: UIView {
    private let valueLabel = UILabel()

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
            "UISlider on iOS 26 features enhanced "
            + "interactions including momentum preservation "
            + "and stretching. The thumb and track adopt "
            + "glass styling."
        ))

        stack.addArrangedSubview(DemoUI.sectionLabel("Standard Slider"))
        let standardSlider = UISlider()
        standardSlider.minimumValue = 0
        standardSlider.maximumValue = 100
        standardSlider.value = 50
        standardSlider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
        stack.addArrangedSubview(standardSlider)

        stack.addArrangedSubview(DemoUI.sectionLabel("Slider with Icons"))
        let iconSlider = UISlider()
        iconSlider.minimumValue = 0
        iconSlider.maximumValue = 100
        iconSlider.value = 30
        iconSlider.minimumValueImage = UIImage(systemName: "speaker.fill")
        iconSlider.maximumValueImage = UIImage(systemName: "speaker.wave.3.fill")
        iconSlider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
        stack.addArrangedSubview(iconSlider)

        stack.addArrangedSubview(DemoUI.sectionLabel("Tinted Slider"))
        let tintedSlider = UISlider()
        tintedSlider.minimumValue = 0
        tintedSlider.maximumValue = 100
        tintedSlider.value = 70
        tintedSlider.minimumTrackTintColor = .systemGreen
        tintedSlider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
        stack.addArrangedSubview(tintedSlider)

        stack.addArrangedSubview(DemoUI.sectionLabel("Brightness Slider"))
        let brightnessSlider = UISlider()
        brightnessSlider.minimumValue = 0
        brightnessSlider.maximumValue = 100
        brightnessSlider.value = 80
        brightnessSlider.minimumValueImage = UIImage(systemName: "sun.min")
        brightnessSlider.maximumValueImage = UIImage(systemName: "sun.max.fill")
        brightnessSlider.minimumTrackTintColor = .systemYellow
        brightnessSlider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
        stack.addArrangedSubview(brightnessSlider)

        valueLabel.text = "Value: 50.0"
        valueLabel.font = .preferredFont(forTextStyle: .footnote)
        valueLabel.textColor = .tertiaryLabel
        valueLabel.textAlignment = .center
        stack.addArrangedSubview(valueLabel)
    }

    @objc private func sliderChanged(_ sender: UISlider) {
        valueLabel.text = String(format: "Value: %.1f", sender.value)
    }
}
