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

    func testUploadButton() throws {
        let selectImageButton = app.buttons["selectImage"]
        XCTAssert(selectImageButton.exists)
        selectImageButton.tap()
        sleep(2)
        let img = app.images.element(boundBy: 0)
        XCTAssert(img.exists)
    }

    func testForm() throws {
        let selectImageButton = app.buttons["selectImage"]
        XCTAssert(selectImageButton.exists)
        selectImageButton.tap()
        sleep(2)
        let img = app.images.element(boundBy: 0)
        XCTAssert(img.exists)
        img.tap()
        sleep(2)
        XCTAssertFalse(selectImageButton.exists)

        let nameField = app.textFields["Name"]
        XCTAssert(nameField.exists)
        let descField = app.textFields["Description"]
        XCTAssert(descField.exists)

        try inputValidation()
        nameField.tap()
        nameField.typeText("aName")
        try inputValidation()
        descField.tap()
        descField.typeText("aDescription")
        let mintButton = app.buttons["Mint!"]
        XCTAssert(mintButton.exists)
        mintButton.tap()
        let successAlert = app.alerts["Successfully minted!"]
        XCTAssert(successAlert.exists)
        successAlert.buttons.element(boundBy: 0).tap()
        XCTAssert(selectImageButton.exists)
    }

    func inputValidation() throws {
        let mintButton = app.buttons["Mint!"]
        XCTAssert(mintButton.exists)
        mintButton.tap()
        let invalidAlert = app.alerts.element(boundBy: 0)
        XCTAssert(invalidAlert.exists)
        invalidAlert.buttons.element(boundBy: 0).tap()
    }
}
