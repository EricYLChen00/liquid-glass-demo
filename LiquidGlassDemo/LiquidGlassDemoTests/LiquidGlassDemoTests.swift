//
//  LiquidGlassDemoTests.swift
//  LiquidGlassDemoTests
//
//  Created by Eric Chen on 2026/2/16.
//

import XCTest
@testable import LiquidGlassDemo

final class LiquidGlassComponentTests: XCTestCase {
    func testAllCasesHas20Components() {
        XCTAssertEqual(LiquidGlassComponent.allCases.count, 20)
    }

    func testEachComponentHasNonEmptyTitle() {
        for component in LiquidGlassComponent.allCases {
            XCTAssertFalse(component.title.isEmpty, "Component \(component) has empty title")
        }
    }

    func testEachComponentHasNonEmptySubtitle() {
        for component in LiquidGlassComponent.allCases {
            XCTAssertFalse(component.subtitle.isEmpty, "Component \(component) has empty subtitle")
        }
    }

    func testEachComponentHasValidSFSymbolIcon() {
        for component in LiquidGlassComponent.allCases {
            XCTAssertFalse(component.iconName.isEmpty, "Component \(component) has empty iconName")
        }
    }

    func testTitlesAreUnique() {
        let titles = LiquidGlassComponent.allCases.map(\.title)
        let uniqueTitles = Set(titles)
        XCTAssertEqual(titles.count, uniqueTitles.count, "Duplicate titles found")
    }

    func testRawValuesAreSequential() {
        let rawValues = LiquidGlassComponent.allCases.map(\.rawValue)
        for (index, rawValue) in rawValues.enumerated() {
            XCTAssertEqual(rawValue, index, "Expected rawValue \(index), got \(rawValue)")
        }
    }
}
