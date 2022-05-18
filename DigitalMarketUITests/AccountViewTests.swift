//
//  AccountTests.swift
//  DigitalMarketUITests
//
//  Created by Zoe Schmitt on 5/17/22.
//

import XCTest

class AccountViewTests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()

        let accountTab = app.buttons.element(boundBy: 2)
        XCTAssert(accountTab.exists)

        accountTab.tap()
        sleep(3)
    }


    func testAccountInformation() throws {
        let addressText = app.staticTexts["Address"]
        XCTAssert(addressText.exists)

        let walletAddressText = app.staticTexts["walletAddress"]
        XCTAssert(walletAddressText.exists)

        let walletBalanceText = app.staticTexts["walletBalance"]
        XCTAssert(walletBalanceText.exists)
    }

    func testPrivateKeyButton() throws {
        let pkButton = app.buttons["Get Private Key"]
        XCTAssert(pkButton.exists)

        pkButton.tap()
        sleep(3)

        let privateKey = app.staticTexts["Private Key-shown-false"]
        XCTAssert(privateKey.exists)

        let mnemonic = app.staticTexts["Mnemonic-shown-false"]
        XCTAssert(mnemonic.exists)

        privateKey.tap()
        XCTAssert(app.staticTexts["Private Key-shown-true"].exists)

        mnemonic.tap()
        XCTAssert(app.staticTexts["Mnemonic-shown-true"].exists)
    }
}
