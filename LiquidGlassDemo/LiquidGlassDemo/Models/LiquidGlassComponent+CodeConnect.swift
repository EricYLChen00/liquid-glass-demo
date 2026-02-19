//
//  LiquidGlassComponent+CodeConnect.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import Foundation

struct CodeConnectInfo {
    let uikitCode: String
    let swiftuiCode: String
}

extension LiquidGlassComponent {

    var codeConnectInfo: CodeConnectInfo {
        Self.codeConnectMap[self] ?? CodeConnectInfo(uikitCode: "", swiftuiCode: "")
    }

    // MARK: - Static Data

    private static let codeConnectMap: [LiquidGlassComponent: CodeConnectInfo] = [
        .navigationBar: CodeConnectInfo(
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
        ),

        .tabBar: CodeConnectInfo(
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
        ),

        .toolbar: CodeConnectInfo(
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
        ),

        .searchBar: CodeConnectInfo(
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
        ),

        .alertAndActionSheet: CodeConnectInfo(
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
        ),

        .glassButton: CodeConnectInfo(
            uikitCode: """
            var config = UIButton.Configuration.glass()
            config.title = "Glass Button"
            config.image = UIImage(systemName: "star")
            let button = UIButton(configuration: config)
            """,
            swiftuiCode: """
            // Simplest approach
            Button("Glass Button") { }
                .buttonStyle(.glass)

            // Custom shape
            Button { } label: {
                Label("Action", systemImage: "star")
            }
            .glassEffect(.regular.interactive(), in: .capsule)
            """
        ),

        .prominentGlassButton: CodeConnectInfo(
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
        ),

        .glassEffectBasic: CodeConnectInfo(
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
        ),

        .glassEffectTinted: CodeConnectInfo(
            uikitCode: """
            let glassEffect = UIGlassEffect()
            let effectView = UIVisualEffectView(
                effect: glassEffect
            )
            let tintView = UIView()
            tintView.backgroundColor = .systemBlue
                .withAlphaComponent(0.3)
            effectView.contentView.insertSubview(tintView, at: 0)
            """,
            swiftuiCode: """
            Text("Tinted Glass")
                .padding()
                .glassEffect(
                    .regular.tinted(with: .blue)
                )
            """
        ),

        .glassContainerMorphing: CodeConnectInfo(
            uikitCode: """
            let containerEffect = UIGlassContainerEffect()
            containerEffect.spacing = 20
            let container = UIVisualEffectView(
                effect: containerEffect
            )

            let childGlass = UIVisualEffectView(
                effect: UIGlassEffect()
            )
            container.contentView.addSubview(childGlass)
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
        ),

        .cornerConfiguration: CodeConnectInfo(
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
        ),

        .segmentedControl: CodeConnectInfo(
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
        ),

        .slider: CodeConnectInfo(
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
        ),

        .switchControl: CodeConnectInfo(
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
        ),

        .datePicker: CodeConnectInfo(
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
        ),

        .progressView: CodeConnectInfo(
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
        ),

        .glassCardView: CodeConnectInfo(
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
        ),

        .animatedGlass: CodeConnectInfo(
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
        ),

        .sfSymbolsOnGlass: CodeConnectInfo(
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
        ),

        .tintedInteractiveButtons: CodeConnectInfo(
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
        ),
    ]
}
