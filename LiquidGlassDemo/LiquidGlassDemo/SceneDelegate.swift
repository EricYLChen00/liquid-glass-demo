//
//  SceneDelegate.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        // Global navigation bar appearance
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundEffect = nil
        navBarAppearance.backgroundColor = .systemRed
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = .white

        // Home tab - Component list
        let listVC = ComponentListViewController()
        let homeNav = UINavigationController(rootViewController: listVC)
        homeNav.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "dollarsign.circle"),
            selectedImage: UIImage(systemName: "dollarsign.circle.fill")
        )

        // AZ Menu tab
        let azMenuVC = PlaceholderViewController(tabName: "AZ Menu")
        let azMenuNav = UINavigationController(rootViewController: azMenuVC)
        azMenuNav.tabBarItem = UITabBarItem(
            title: "AZ Menu",
            image: UIImage(systemName: "line.3.horizontal"),
            selectedImage: UIImage(systemName: "line.3.horizontal")
        )

        // Games tab
        let gamesVC = PlaceholderViewController(tabName: "Games")
        let gamesNav = UINavigationController(rootViewController: gamesVC)
        gamesNav.tabBarItem = UITabBarItem(
            title: "Games",
            image: UIImage(systemName: "gamecontroller"),
            selectedImage: UIImage(systemName: "gamecontroller.fill")
        )

        // Open Bets tab
        let openBetsVC = PlaceholderViewController(tabName: "Open Bets")
        let openBetsNav = UINavigationController(rootViewController: openBetsVC)
        openBetsNav.tabBarItem = UITabBarItem(
            title: "Open Bets",
            image: UIImage(systemName: "arrow.triangle.2.circlepath"),
            selectedImage: UIImage(systemName: "arrow.triangle.2.circlepath")
        )
        openBetsNav.tabBarItem.badgeValue = "63"

        // Me tab
        let meVC = AboutViewController()
        let meNav = UINavigationController(rootViewController: meVC)
        meNav.tabBarItem = UITabBarItem(
            title: "Me",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeNav, azMenuNav, gamesNav, openBetsNav, meNav]

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
}

// MARK: - Placeholder VC for non-Home tabs

private final class PlaceholderViewController: UIViewController {
    private let tabName: String

    init(tabName: String) {
        self.tabName = tabName
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = tabName
        view.backgroundColor = .systemBackground

        let label = UILabel()
        label.text = tabName
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textColor = .tertiaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
