//
//  SearchBarDemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

final class SearchBarDemoView: UIView, UISearchBarDelegate {
    private let resultLabel = UILabel()

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
            "The search bar automatically adopts Liquid Glass when compiled with Xcode 26 SDK. Type in the search bar to see the glass styling."
        ))

        let searchBar = UISearchBar()
        searchBar.placeholder = "Search components..."
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        stack.addArrangedSubview(searchBar)

        let prominentSearchBar = UISearchBar()
        prominentSearchBar.placeholder = "Prominent search bar"
        prominentSearchBar.searchBarStyle = .prominent
        prominentSearchBar.delegate = self
        stack.addArrangedSubview(prominentSearchBar)

        resultLabel.text = "Type something to search"
        resultLabel.font = .preferredFont(forTextStyle: .footnote)
        resultLabel.textColor = .tertiaryLabel
        resultLabel.textAlignment = .center
        stack.addArrangedSubview(resultLabel)
    }

    // MARK: - UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            resultLabel.text = "Type something to search"
        } else {
            resultLabel.text = "Searching for: \"\(searchText)\""
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        resultLabel.text = "Search submitted: \"\(searchBar.text ?? "")\""
    }
}
