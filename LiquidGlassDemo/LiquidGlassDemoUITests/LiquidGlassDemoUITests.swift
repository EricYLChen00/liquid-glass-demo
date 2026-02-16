//
//  LiquidGlassDemoUITests.swift
//  LiquidGlassDemoUITests
//
//  Created by Eric Chen on 2026/2/16.
//

import XCTest

final class LiquidGlassDemoUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    @MainActor
    func testFirstRowIsNavigationBar() {
        let cell = app.tables.firstMatch.cells.element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 3))
        XCTAssertTrue(cell.staticTexts["Navigation Bar"].exists)
    }

    // MARK: - Navigation

    @MainActor
    func testTapComponentNavigatesToDetail() {
        let cell = app.tables.firstMatch.cells.element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 3))
        cell.tap()

        let detailNavBar = app.navigationBars["Navigation Bar"]
        XCTAssertTrue(detailNavBar.waitForExistence(timeout: 3))
    }

    @MainActor
    func testBackNavigationReturnsToList() {
        let cell = app.tables.firstMatch.cells.element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 3))
        cell.tap()

        let backButton = app.navigationBars.buttons.firstMatch
        XCTAssertTrue(backButton.waitForExistence(timeout: 3))
        backButton.tap()

        let listNavBar = app.navigationBars["Liquid Glass"]
        XCTAssertTrue(listNavBar.waitForExistence(timeout: 3))
    }

    // MARK: - Tab Bar

    @MainActor
    func testTabBarHasFiveTabs() {
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 3))
        XCTAssertEqual(tabBar.buttons.count, 5)
    }

    @MainActor
    func testTabBarSwitching() {
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 3))

        tabBar.buttons["Games"].tap()
        XCTAssertTrue(app.navigationBars["Games"].waitForExistence(timeout: 3))

        tabBar.buttons["Home"].tap()
        XCTAssertTrue(app.navigationBars["Liquid Glass"].waitForExistence(timeout: 3))
    }
}
