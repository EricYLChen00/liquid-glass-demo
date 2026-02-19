//
//  TabBarDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class TabBarDemoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let stack = addPinnedStack()
        stack.addArrangedSubview(DemoUI.infoLabel(
            "The tab bar automatically adopts Liquid Glass "
            + "when compiled with Xcode 26 SDK. Look at the bottom "
            + "of the screen to see the glass tab bar."
        ))
    }
}
