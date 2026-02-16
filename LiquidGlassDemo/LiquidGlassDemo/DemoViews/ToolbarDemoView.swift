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

    // Save original nav bar appearance to restore on exit
    private var savedStandardAppearance: UINavigationBarAppearance?
    private var savedScrollEdgeAppearance: UINavigationBarAppearance?
    private var savedCompactAppearance: UINavigationBarAppearance?
    private var savedTintColor: UIColor?

    init(parentVC: UIViewController) {
        self.parentVC = parentVC
        super.init(frame: .zero)
        setupUI()
        saveNavBarAppearance()
        applyGlassNavBar()
        showGroupedNavBarItems()
    }

    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if newWindow == nil {
            restoreNavBarAppearance()
            parentVC?.navigationItem.rightBarButtonItems = nil
            parentVC?.navigationController?.setToolbarHidden(true, animated: false)
        }
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
            "In iOS 26, navigation bar items automatically get Liquid Glass styling.\n\n"
            + "Adjacent items share one glass pill. Use fixedSpace(0) to split them into separate glass circles."
        )
        stack.addArrangedSubview(infoLabel)

        // Section: Navigation Bar Items (HIG style)
        let sectionLabel = UILabel()
        sectionLabel.text = "Navigation Bar Items"
        sectionLabel.font = .preferredFont(forTextStyle: .headline)
        stack.addArrangedSubview(sectionLabel)

        let groupedButton = createActionButton(
            title: "Grouped: Share + More (pill)",
            action: #selector(showGroupedNavBarItems)
        )
        let separatedButton = createActionButton(
            title: "Separated: fixedSpace(0)",
            action: #selector(showSeparatedNavBarItems)
        )
        let mixedButton = createActionButton(
            title: "Mixed: Compose | Share+More",
            action: #selector(showMixedNavBarItems)
        )

        stack.addArrangedSubview(groupedButton)
        stack.addArrangedSubview(separatedButton)
        stack.addArrangedSubview(mixedButton)

        // Section: Bottom Toolbar
        let bottomSection = UILabel()
        bottomSection.text = "Bottom Toolbar"
        bottomSection.font = .preferredFont(forTextStyle: .headline)
        stack.addArrangedSubview(bottomSection)

        let showBottomButton = createActionButton(
            title: "Show Bottom Toolbar",
            action: #selector(showBottomToolbar)
        )
        let hideBottomButton = createActionButton(
            title: "Hide Bottom Toolbar",
            action: #selector(hideBottomToolbar)
        )

        stack.addArrangedSubview(showBottomButton)
        stack.addArrangedSubview(hideBottomButton)

        // Reset
        let resetButton = createActionButton(title: "Reset All", action: #selector(resetAll))
        stack.addArrangedSubview(resetButton)

        statusLabel.text = "Grouped nav bar items (share + more in one pill)"
        statusLabel.font = .preferredFont(forTextStyle: .footnote)
        statusLabel.textColor = .tertiaryLabel
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
        stack.addArrangedSubview(statusLabel)
    }

    private func saveNavBarAppearance() {
        guard let navBar = parentVC?.navigationController?.navigationBar else { return }
        savedStandardAppearance = navBar.standardAppearance.copy() as UINavigationBarAppearance
        savedScrollEdgeAppearance = navBar.scrollEdgeAppearance?.copy() as? UINavigationBarAppearance
        savedCompactAppearance = navBar.compactAppearance?.copy() as? UINavigationBarAppearance
        savedTintColor = navBar.tintColor
    }

    private func restoreNavBarAppearance() {
        guard let navBar = parentVC?.navigationController?.navigationBar else { return }
        if let saved = savedStandardAppearance {
            navBar.standardAppearance = saved
        }
        navBar.scrollEdgeAppearance = savedScrollEdgeAppearance
        navBar.compactAppearance = savedCompactAppearance
        navBar.tintColor = savedTintColor
    }

    /// Temporarily switch nav bar to glass (remove custom red background)
    private func applyGlassNavBar() {
        guard let navBar = parentVC?.navigationController?.navigationBar else { return }
        let glassAppearance = UINavigationBarAppearance()
        glassAppearance.configureWithDefaultBackground()
        navBar.standardAppearance = glassAppearance
        navBar.scrollEdgeAppearance = glassAppearance
        navBar.compactAppearance = glassAppearance
        navBar.tintColor = nil
    }

    // MARK: - Nav Bar Items: Grouped (shared glass pill)

    @objc private func showGroupedNavBarItems() {
        // Adjacent items → share one glass pill
        let shareItem = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up"),
            style: .plain, target: nil, action: nil
        )
        let moreItem = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .plain, target: nil, action: nil
        )
        // No separator: share + more grouped into one pill
        parentVC?.navigationItem.rightBarButtonItems = [moreItem, shareItem]
        statusLabel.text = "Grouped: share + more share one glass pill"
    }

    // MARK: - Nav Bar Items: Separated (fixedSpace splits into individual circles)

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
        // fixedSpace(0) between each → all separate glass circles
        parentVC?.navigationItem.rightBarButtonItems = [moreItem, separator2, shareItem, separator, composeItem]
        statusLabel.text = "Separated: each item is its own glass circle (fixedSpace(0))"
    }

    // MARK: - Nav Bar Items: Mixed (HIG style)

    @objc private func showMixedNavBarItems() {
        // Compose gets its own circle, Share + More grouped in a pill
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
        // rightBarButtonItems order: right-to-left
        // more, share (grouped pill) | fixedSpace(0) | compose (solo circle)
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

    // MARK: - Reset

    @objc private func resetAll() {
        parentVC?.navigationItem.rightBarButtonItems = nil
        parentVC?.navigationController?.setToolbarHidden(true, animated: true)
        statusLabel.text = "Reset: all items cleared"
    }

    // MARK: - Helpers

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
