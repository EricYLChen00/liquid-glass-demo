//
//  ComponentDetailViewController.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class ComponentDetailViewController: UIViewController {

    // MARK: - Properties

    private let component: LiquidGlassComponent
    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()

    // MARK: - Init

    init(component: LiquidGlassComponent) {
        self.component = component
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = (component != .tabBar)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = component.title
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        setupScrollView()
        addDemoView()
    }

    // MARK: - Setup

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        contentStack.axis = .vertical
        contentStack.spacing = 16
        contentStack.alignment = .fill
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
        ])
    }

    private func addDemoView() {
        let demoView = createDemoView(for: component)
        contentStack.addArrangedSubview(demoView)
    }

    // MARK: - Factory

    private func createDemoView(for component: LiquidGlassComponent) -> UIView {
        switch component {
        case .navigationBar:
            return NavigationBarDemoView(parentVC: self)
        case .tabBar:
            return TabBarDemoView(parentVC: self)
        case .toolbar:
            return ToolbarDemoView(parentVC: self)
        case .searchBar:
            return SearchBarDemoView()
        case .alertAndActionSheet:
            return AlertDemoView(parentVC: self)
        case .glassButton:
            return GlassButtonDemoView()
        case .prominentGlassButton:
            return ProminentGlassButtonDemoView()
        case .glassEffectBasic:
            return GlassEffectDemoView()
        case .glassEffectTinted:
            return TintedGlassDemoView()
        case .glassContainerMorphing:
            return GlassContainerDemoView()
        case .cornerConfiguration:
            return CornerConfigDemoView()
        case .segmentedControl:
            return SegmentedControlDemoView()
        case .slider:
            return SliderDemoView()
        case .switchControl:
            return SwitchDemoView()
        case .datePicker:
            return DatePickerDemoView()
        case .progressView:
            return ProgressViewDemoView()
        case .glassCardView:
            return GlassCardDemoView()
        case .animatedGlass:
            return AnimatedGlassDemoView()
        case .sfSymbolsOnGlass:
            return SFSymbolsDemoView()
        case .tintedInteractiveButtons:
            return TintedInteractiveButtonsDemoView()
        }
    }
}
