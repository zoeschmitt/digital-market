//
//  MintViewTests.swift
//  DigitalMarketUITests
//
//  Created by Zoe Schmitt on 5/17/22.
//

import XCTest

class MintViewTests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()

        let mintTab = app.buttons.element(boundBy: 1)
        XCTAssert(mintTab.exists)

        mintTab.tap()
    }
}
