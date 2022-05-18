//
//  Test.swift
//  DigitalMarketUITests
//
//  Created by Zoe Schmitt on 5/17/22.
//

import XCTest

class HomeViewTests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    func testTitleLoaded() {
        let marketplace = app.staticTexts["Marketplace"]
        XCTAssert(marketplace.exists)
    }

    func testSearchBar() {
        let searchButton = app.buttons["searchButton"]
        XCTAssert(searchButton.exists)

        let marketplace = app.staticTexts["Marketplace"]
        XCTAssert(marketplace.exists)

        let searchField = app.searchFields["Search"]
        XCTAssertFalse(searchField.exists)

        let closeSearchButton = app.buttons["closeSearchButton"]
        XCTAssertFalse(closeSearchButton.exists)

        searchButton.tap()

        XCTAssertFalse(marketplace.exists)
        XCTAssert(closeSearchButton.exists)
        XCTAssert(searchField.exists)
    }

    func testNFTList() {
        let nftList = app.scrollViews["NFTList"]
        XCTAssert(nftList.exists)

        let nftCards = nftList.descendants(matching: .button)
        let nft = nftCards.element(boundBy: 0)
        nft.tap()

        XCTAssertFalse(nftList.exists)

        let nftView = app.scrollViews["NFTView"]
        XCTAssert(nftView.exists)
    }
}
