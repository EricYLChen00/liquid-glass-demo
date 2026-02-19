//
//  ToolbarDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class ToolbarDemoView: UIView {
    private weak var parentVC: UIViewController?
    private let statusLabel = UILabel()

    init(parentVC: UIViewController) {
        self.parentVC = parentVC
        super.init(frame: .zero)
        setupUI()
        showGroupedNavBarItems()
    }

    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if newWindow == nil {
            parentVC?.navigationItem.rightBarButtonItems = nil
            parentVC?.navigationController?.setToolbarHidden(true, animated: false)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let stack = addPinnedStack()

        stack.addArrangedSubview(DemoUI.infoLabel(
            "In iOS 26, navigation bar items automatically get Liquid Glass styling.\n\n"
            + "Adjacent items share one glass pill. Use fixedSpace(0) to split them into separate glass circles."
        ))

        let sectionLabel = UILabel()
        sectionLabel.text = "Navigation Bar Items"
        sectionLabel.font = .preferredFont(forTextStyle: .headline)
        stack.addArrangedSubview(sectionLabel)

        stack.addArrangedSubview(DemoUI.actionButton(
            title: "Grouped: Share + More (pill)",
            target: self, action: #selector(showGroupedNavBarItems)
        ))
        stack.addArrangedSubview(DemoUI.actionButton(
            title: "Separated: fixedSpace(0)",
            target: self, action: #selector(showSeparatedNavBarItems)
        ))
        stack.addArrangedSubview(DemoUI.actionButton(
            title: "Mixed: Compose | Share+More",
            target: self, action: #selector(showMixedNavBarItems)
        ))

        let bottomSection = UILabel()
        bottomSection.text = "Bottom Toolbar"
        bottomSection.font = .preferredFont(forTextStyle: .headline)
        stack.addArrangedSubview(bottomSection)

        stack.addArrangedSubview(DemoUI.actionButton(
            title: "Show Bottom Toolbar",
            target: self, action: #selector(showBottomToolbar)
        ))
        stack.addArrangedSubview(DemoUI.actionButton(
            title: "Hide Bottom Toolbar",
            target: self, action: #selector(hideBottomToolbar)
        ))

        stack.addArrangedSubview(DemoUI.actionButton(
            title: "Reset All",
            target: self, action: #selector(resetAll)
        ))

        statusLabel.text = "Grouped nav bar items (share + more in one pill)"
        statusLabel.font = .preferredFont(forTextStyle: .footnote)
        statusLabel.textColor = .tertiaryLabel
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
        stack.addArrangedSubview(statusLabel)
    }

    // MARK: - Nav Bar Items

    @objc private func showGroupedNavBarItems() {
        let shareItem = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up"),
            style: .plain, target: nil, action: nil
        )
        let moreItem = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .plain, target: nil, action: nil
        )
        parentVC?.navigationItem.rightBarButtonItems = [moreItem, shareItem]
        statusLabel.text = "Grouped: share + more share one glass pill"
    }

    @objc private func showSeparatedNavBarItems() {
        let composeItem = UIBarButtonItem(
            image: UIImage(systemName: "square.and.pencil"),
            style: .plain, target: nil, action: nil
        )
        let separator = UIBarButtonItem.fixedSpace(0)
        let shareItem = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up"),
            style: .plain, target: nil, action: nil
        )
        let separator2 = UIBarButtonItem.fixedSpace(0)
        let moreItem = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .plain, target: nil, action: nil
        )
        parentVC?.navigationItem.rightBarButtonItems = [moreItem, separator2, shareItem, separator, composeItem]
        statusLabel.text = "Separated: each item is its own glass circle (fixedSpace(0))"
    }

    @objc private func showMixedNavBarItems() {
        let composeItem = UIBarButtonItem(
            image: UIImage(systemName: "square.and.pencil"),
            style: .plain, target: nil, action: nil
        )
        let separator = UIBarButtonItem.fixedSpace(0)
        let shareItem = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up"),
            style: .plain, target: nil, action: nil
        )
        let moreItem = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .plain, target: nil, action: nil
        )
        parentVC?.navigationItem.rightBarButtonItems = [moreItem, shareItem, separator, composeItem]
        statusLabel.text = "Mixed: compose (circle) | share+more (pill) — matches HIG"
    }

    // MARK: - Bottom Toolbar

    @objc private func showBottomToolbar() {
        parentVC?.navigationController?.setToolbarHidden(false, animated: true)
        let locationItem = UIBarButtonItem(
            image: UIImage(systemName: "location"),
            style: .plain, target: nil, action: nil
        )
        let flexSpace = UIBarButtonItem.flexibleSpace()
        let cameraItem = UIBarButtonItem(
            image: UIImage(systemName: "camera"),
            style: .plain, target: nil, action: nil
        )
        let shareItem = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up"),
            style: .plain, target: nil, action: nil
        )
        parentVC?.toolbarItems = [locationItem, flexSpace, cameraItem, flexSpace, shareItem]
        statusLabel.text = "Bottom toolbar shown with glass items"
    }

    @objc private func hideBottomToolbar() {
        parentVC?.navigationController?.setToolbarHidden(true, animated: true)
        statusLabel.text = "Bottom toolbar hidden"
    }

    @objc private func resetAll() {
        parentVC?.navigationItem.rightBarButtonItems = nil
        parentVC?.navigationController?.setToolbarHidden(true, animated: true)
        statusLabel.text = "Reset: all items cleared"
    }
}
