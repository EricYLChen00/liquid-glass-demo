//
//  ComponentListViewController.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class ComponentListViewController: UITableViewController {

    // MARK: - Properties

    private let components = LiquidGlassComponent.allCases
    private let cellReuseID = "ComponentCell"

    // MARK: - Lifecycle

    init() {
        super.init(style: .insetGrouped)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Liquid Glass"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
        setupAppearanceButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyRedNavBarAppearance()
    }

    private func applyRedNavBarAppearance() {
        guard let navBar = navigationController?.navigationBar else { return }
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundEffect = nil
        appearance.backgroundColor = .systemRed
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBar.standardAppearance = appearance
        navBar.scrollEdgeAppearance = appearance
        navBar.compactAppearance = appearance
        navBar.tintColor = .white
    }

    // MARK: - Appearance Toggle

    private func setupAppearanceButton() {
        let icon = appearanceIcon(for: view.window?.overrideUserInterfaceStyle ?? .unspecified)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: icon,
            style: .plain,
            target: self,
            action: #selector(showAppearanceMenu)
        )
    }

    private func appearanceIcon(for style: UIUserInterfaceStyle) -> UIImage? {
        switch style {
        case .dark:
            return UIImage(systemName: "moon.fill")
        case .light:
            return UIImage(systemName: "sun.max.fill")
        default:
            return UIImage(systemName: "circle.lefthalf.filled")
        }
    }

    @objc private func showAppearanceMenu() {
        let sheet = UIAlertController(title: "Appearance", message: nil, preferredStyle: .actionSheet)

        sheet.addAction(UIAlertAction(title: "Light", style: .default) { [weak self] _ in
            self?.setAppearance(.light)
        })
        sheet.addAction(UIAlertAction(title: "Dark", style: .default) { [weak self] _ in
            self?.setAppearance(.dark)
        })
        sheet.addAction(UIAlertAction(title: "System", style: .default) { [weak self] _ in
            self?.setAppearance(.unspecified)
        })
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(sheet, animated: true)
    }

    private func setAppearance(_ style: UIUserInterfaceStyle) {
        view.window?.overrideUserInterfaceStyle = style
        navigationItem.rightBarButtonItem?.image = appearanceIcon(for: style)
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        components.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath)
        let component = components[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = component.title
        content.secondaryText = component.subtitle
        content.image = UIImage(systemName: component.iconName)
        content.secondaryTextProperties.color = .secondaryLabel
        content.secondaryTextProperties.numberOfLines = 2
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let component = components[indexPath.row]
        let detailVC = ComponentDetailViewController(component: component)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
