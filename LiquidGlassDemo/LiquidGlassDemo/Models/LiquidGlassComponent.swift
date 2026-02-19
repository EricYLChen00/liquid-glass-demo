//
//  LiquidGlassComponent.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

enum LiquidGlassComponent: Int, CaseIterable {
    case navigationBar
    case tabBar
    case toolbar
    case searchBar
    case alertAndActionSheet
    case glassButton
    case prominentGlassButton
    case glassEffectBasic
    case glassEffectTinted
    case glassContainerMorphing
    case cornerConfiguration
    case segmentedControl
    case slider
    case switchControl
    case datePicker
    case progressView
    case glassCardView
    case animatedGlass
    case sfSymbolsOnGlass
    case tintedInteractiveButtons

    var title: String {
        switch self {
        case .navigationBar: return "Navigation Bar"
        case .tabBar: return "Tab Bar"
        case .toolbar: return "Toolbar"
        case .searchBar: return "Search Bar"
        case .alertAndActionSheet: return "Alert & Action Sheet"
        case .glassButton: return "Glass Button"
        case .prominentGlassButton: return "Prominent Glass Button"
        case .glassEffectBasic: return "Glass Effect (Basic)"
        case .glassEffectTinted: return "Glass Effect (Tinted)"
        case .glassContainerMorphing: return "Glass Container (Morphing)"
        case .cornerConfiguration: return "Corner Configuration"
        case .segmentedControl: return "Segmented Control"
        case .slider: return "Slider"
        case .switchControl: return "Switch"
        case .datePicker: return "Date Picker"
        case .progressView: return "Progress View"
        case .glassCardView: return "Glass Card View"
        case .animatedGlass: return "Animated Glass"
        case .sfSymbolsOnGlass: return "SF Symbols on Glass"
        case .tintedInteractiveButtons: return "Tinted Interactive Buttons"
        }
    }

    var subtitle: String {
        switch self {
        case .navigationBar: return "Auto-adopted glass navigation bar with bar button items"
        case .tabBar: return "Auto-adopted glass tab bar with minimize behavior"
        case .toolbar: return "Auto-adopted glass toolbar with shared background"
        case .searchBar: return "Auto-adopted glass search bar"
        case .alertAndActionSheet: return "Glass-styled alerts and action sheets"
        case .glassButton: return "UIButton with .glass() configuration"
        case .prominentGlassButton: return "UIButton with .prominentGlass() configuration"
        case .glassEffectBasic: return "UIVisualEffectView + UIGlassEffect"
        case .glassEffectTinted: return "UIGlassEffect with color tinting"
        case .glassContainerMorphing: return "UIGlassContainerEffect with morphing animation"
        case .cornerConfiguration: return "Capsule, circle, and rounded rect corners"
        case .segmentedControl: return "UISegmentedControl with glass styling"
        case .slider: return "UISlider with enhanced features"
        case .switchControl: return "UISwitch with updated glass appearance"
        case .datePicker: return "UIDatePicker with multiple styles"
        case .progressView: return "UIProgressView with animated progress"
        case .glassCardView: return "Custom reusable glass card component"
        case .animatedGlass: return "Materialize and dematerialize glass animation"
        case .sfSymbolsOnGlass: return "SF Symbol icons on glass circles"
        case .tintedInteractiveButtons: return "Color-coded glass buttons with tap feedback"
        }
    }

    var iconName: String {
        switch self {
        case .navigationBar: return "rectangle.topthird.inset.filled"
        case .tabBar: return "dock.rectangle"
        case .toolbar: return "rectangle.bottomthird.inset.filled"
        case .searchBar: return "magnifyingglass"
        case .alertAndActionSheet: return "exclamationmark.triangle"
        case .glassButton: return "button.horizontal"
        case .prominentGlassButton: return "button.horizontal.fill"
        case .glassEffectBasic: return "square.on.square"
        case .glassEffectTinted: return "paintpalette"
        case .glassContainerMorphing: return "rectangle.3.group"
        case .cornerConfiguration: return "square.and.pencil"
        case .segmentedControl: return "rectangle.split.3x1"
        case .slider: return "slider.horizontal.3"
        case .switchControl: return "switch.2"
        case .datePicker: return "calendar"
        case .progressView: return "chart.bar.fill"
        case .glassCardView: return "rectangle.on.rectangle"
        case .animatedGlass: return "wand.and.stars"
        case .sfSymbolsOnGlass: return "star.circle"
        case .tintedInteractiveButtons: return "circle.grid.2x2.fill"
        }
    }

    var codeConnectInfo: CodeConnectInfo {
        switch self {
        case .navigationBar:
            return CodeConnectInfo(
                uikitCode: """
                // Auto-adopted in iOS 26
                let navBar = UINavigationBar()
                // Customize bar button items:
                navigationItem.rightBarButtonItems = [item1, item2]
                """,
                swiftuiCode: """
                NavigationStack {
                    ContentView()
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button("Action") { }
                            }
                        }
                }
                """
            )

        case .tabBar:
            return CodeConnectInfo(
                uikitCode: """
                // Auto-adopted in iOS 26
                let tabBarController = UITabBarController()
                tabBarController.viewControllers = [vc1, vc2]
                // Badge:
                vc.tabBarItem.badgeValue = "3"
                """,
                swiftuiCode: """
                TabView {
                    Tab("Home", systemImage: "house") {
                        HomeView()
                    }
                    Tab("Settings", systemImage: "gear") {
                        SettingsView()
                    }
                }
                """
            )

        case .toolbar:
            return CodeConnectInfo(
                uikitCode: """
                // Adjacent items share one glass pill
                let items = [shareItem, moreItem]
                navigationItem.rightBarButtonItems = items

                // fixedSpace(0) splits into separate circles
                let separated = [item1, .fixedSpace(0), item2]
                navigationItem.rightBarButtonItems = separated
                """,
                swiftuiCode: """
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button { } label: { Image(systemName: "square.and.arrow.up") }
                        Button { } label: { Image(systemName: "ellipsis") }
                    }
                }
                """
            )

        case .searchBar:
            return CodeConnectInfo(
                uikitCode: """
                // Auto-adopted in iOS 26
                let searchBar = UISearchBar()
                searchBar.placeholder = "Search..."
                searchBar.searchBarStyle = .minimal
                """,
                swiftuiCode: """
                @State private var searchText = ""

                NavigationStack {
                    List { ... }
                        .searchable(text: $searchText)
                }
                """
            )

        case .alertAndActionSheet:
            return CodeConnectInfo(
                uikitCode: """
                // Alert
                let alert = UIAlertController(
                    title: "Title", message: "Message",
                    preferredStyle: .alert
                )
                // Action Sheet
                let sheet = UIAlertController(
                    title: "Title", message: nil,
                    preferredStyle: .actionSheet
                )
                """,
                swiftuiCode: """
                // Alert
                .alert("Title", isPresented: $showAlert) {
                    Button("OK") { }
                }
                // Confirmation Dialog
                .confirmationDialog("Title", isPresented: $show) {
                    Button("Option 1") { }
                }
                """
            )

        case .glassButton:
            return CodeConnectInfo(
                uikitCode: """
                var config = UIButton.Configuration.glass()
                config.title = "Glass Button"
                config.image = UIImage(systemName: "star")
                let button = UIButton(configuration: config)
                """,
                swiftuiCode: """
                Button("Glass Button") { }
                    .glassEffect(.regular.interactive(), in: .capsule)

                // Or with icon
                Button { } label: {
                    Label("Action", systemImage: "star")
                }
                .glassEffect(.regular.interactive(), in: .capsule)
                """
            )

        case .prominentGlassButton:
            return CodeConnectInfo(
                uikitCode: """
                var config = UIButton.Configuration.prominentGlass()
                config.title = "Prominent"
                config.baseBackgroundColor = .systemBlue
                let button = UIButton(configuration: config)
                """,
                swiftuiCode: """
                Button("Prominent") { }
                    .glassEffect(
                        .regular.prominent(), in: .capsule
                    )

                // With tint
                Button("Tinted") { }
                    .glassEffect(
                        .regular.prominent().tinted(with: .blue),
                        in: .capsule
                    )
                """
            )

        case .glassEffectBasic:
            return CodeConnectInfo(
                uikitCode: """
                let glassEffect = UIGlassEffect()
                let effectView = UIVisualEffectView(
                    effect: glassEffect
                )
                effectView.cornerConfiguration = .capsule(
                    maximumRadius: 22
                )
                // Add content to effectView.contentView
                """,
                swiftuiCode: """
                VStack {
                    Image(systemName: "star.fill")
                    Text("Glass Card")
                }
                .padding()
                .glassEffect()
                """
            )

        case .glassEffectTinted:
            return CodeConnectInfo(
                uikitCode: """
                let glassEffect = UIGlassEffect()
                let effectView = UIVisualEffectView(
                    effect: glassEffect
                )
                // Add tint via subview
                let tintView = UIView()
                tintView.backgroundColor = .systemBlue
                    .withAlphaComponent(0.3)
                effectView.contentView.addSubview(tintView)
                """,
                swiftuiCode: """
                Text("Tinted Glass")
                    .padding()
                    .glassEffect(
                        .regular.tinted(with: .blue)
                    )
                """
            )

        case .glassContainerMorphing:
            return CodeConnectInfo(
                uikitCode: """
                let containerEffect = UIGlassContainerEffect()
                containerEffect.spacing = 20
                let container = UIVisualEffectView(
                    effect: containerEffect
                )
                // Add child UIVisualEffectView(effect: UIGlassEffect())
                """,
                swiftuiCode: """
                GlassEffectContainer(spacing: 20) {
                    HStack(spacing: 20) {
                        Image(systemName: "star")
                            .frame(width: 60, height: 60)
                            .glassEffect()
                        Image(systemName: "heart")
                            .frame(width: 60, height: 60)
                            .glassEffect()
                    }
                }
                """
            )

        case .cornerConfiguration:
            return CodeConnectInfo(
                uikitCode: """
                // Capsule (fully rounded)
                effectView.cornerConfiguration = .capsule()

                // Capsule with max radius
                effectView.cornerConfiguration = .capsule(
                    maximumRadius: 22
                )
                """,
                swiftuiCode: """
                // Capsule
                .glassEffect(in: .capsule)

                // Circle
                .glassEffect(in: .circle)

                // Rounded rect
                .glassEffect(
                    in: .rect(cornerRadius: 16)
                )
                """
            )

        case .segmentedControl:
            return CodeConnectInfo(
                uikitCode: """
                // Auto-adopted in iOS 26
                let sc = UISegmentedControl(items: [
                    "First", "Second", "Third"
                ])
                sc.selectedSegmentIndex = 0
                """,
                swiftuiCode: """
                @State private var selection = 0

                Picker("Options", selection: $selection) {
                    Text("First").tag(0)
                    Text("Second").tag(1)
                    Text("Third").tag(2)
                }
                .pickerStyle(.segmented)
                """
            )

        case .slider:
            return CodeConnectInfo(
                uikitCode: """
                // Auto-adopted in iOS 26
                let slider = UISlider()
                slider.minimumValue = 0
                slider.maximumValue = 100
                slider.value = 50
                """,
                swiftuiCode: """
                @State private var value = 50.0

                Slider(value: $value, in: 0...100)

                // With step
                Slider(value: $value, in: 0...100, step: 5)
                """
            )

        case .switchControl:
            return CodeConnectInfo(
                uikitCode: """
                // Auto-adopted in iOS 26
                let toggle = UISwitch()
                toggle.isOn = true
                toggle.onTintColor = .systemGreen
                """,
                swiftuiCode: """
                @State private var isOn = true

                Toggle("Feature", isOn: $isOn)
                Toggle(isOn: $isOn) {
                    Label("Wi-Fi", systemImage: "wifi")
                }
                """
            )

        case .datePicker:
            return CodeConnectInfo(
                uikitCode: """
                // Auto-adopted in iOS 26
                let picker = UIDatePicker()
                picker.datePickerMode = .dateAndTime
                picker.preferredDatePickerStyle = .compact
                // Styles: .compact, .inline, .wheels
                """,
                swiftuiCode: """
                @State private var date = Date()

                DatePicker("Date", selection: $date)
                    .datePickerStyle(.compact)

                // Or inline
                DatePicker("Date", selection: $date)
                    .datePickerStyle(.graphical)
                """
            )

        case .progressView:
            return CodeConnectInfo(
                uikitCode: """
                // Auto-adopted in iOS 26
                let progressView = UIProgressView(
                    progressViewStyle: .default
                )
                progressView.progress = 0.6
                progressView.tintColor = .systemBlue
                """,
                swiftuiCode: """
                // Determinate
                ProgressView(value: 0.6)

                // Indeterminate
                ProgressView()

                // With label
                ProgressView("Loading...", value: 0.6)
                """
            )

        case .glassCardView:
            return CodeConnectInfo(
                uikitCode: """
                let glassEffect = UIGlassEffect()
                let card = UIVisualEffectView(
                    effect: glassEffect
                )
                card.cornerConfiguration = .capsule(
                    maximumRadius: 20
                )
                // Add title + body labels to card.contentView
                """,
                swiftuiCode: """
                VStack(alignment: .leading, spacing: 8) {
                    Text("Card Title").font(.headline)
                    Text("Card body content here.")
                        .font(.body)
                }
                .padding()
                .glassEffect()
                """
            )

        case .animatedGlass:
            return CodeConnectInfo(
                uikitCode: """
                // Materialize
                UIView.animate(withDuration: 0.5) {
                    effectView.effect = UIGlassEffect()
                }
                // Dematerialize
                UIView.animate(withDuration: 0.5) {
                    effectView.effect = nil
                }
                """,
                swiftuiCode: """
                @State private var showGlass = false

                Text("Content")
                    .padding()
                    .glassEffect(.regular, isEnabled: showGlass)

                Button("Toggle") {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showGlass.toggle()
                    }
                }
                """
            )

        case .sfSymbolsOnGlass:
            return CodeConnectInfo(
                uikitCode: """
                let iconView = UIImageView(
                    image: UIImage(systemName: "star")
                )
                // Use plain variant on iOS 26 (no .fill)
                let glass = UIVisualEffectView(
                    effect: UIGlassEffect()
                )
                glass.contentView.addSubview(iconView)
                """,
                swiftuiCode: """
                Image(systemName: "star")
                    .font(.title2)
                    .frame(width: 44, height: 44)
                    .glassEffect(
                        .regular.interactive(), in: .circle
                    )
                    .contentShape(Circle()) // hit testing
                """
            )

        case .tintedInteractiveButtons:
            return CodeConnectInfo(
                uikitCode: """
                var config = UIButton.Configuration.glass()
                config.title = "Action"
                config.baseBackgroundColor = .systemRed
                config.baseForegroundColor = .systemRed
                let button = UIButton(configuration: config)
                """,
                swiftuiCode: """
                Button("Action") { }
                    .glassEffect(
                        .regular.tinted(with: .red).interactive(),
                        in: .capsule
                    )
                """
            )
        }
    }
}
