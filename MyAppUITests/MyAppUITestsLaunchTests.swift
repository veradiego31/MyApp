//
//  MyAppUITestsLaunchTests.swift
//  MyAppUITests
//
//  Created by Diego Vera on 2023-09-26.
//

import XCTest

final class MyAppUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        false
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launchEnvironment["UITEST_DISABLE_ANIMATIONS"] = "1"
        app.launch()

        XCTAssertTrue(
            app.wait(for: .runningForeground, timeout: 30),
            "App did not reach foreground in time."
        )

        // Wait until one of the known stable launch states exists.
        let isReady =
            app.staticTexts["No Event Set"].waitForExistence(timeout: 15) ||
            app.buttons["Set Event"].waitForExistence(timeout: 5) ||
            app.buttons["Edit"].waitForExistence(timeout: 5)
        XCTAssertTrue(isReady, "Launch UI did not reach a stable state in time.")

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = ProcessInfo.processInfo.environment["CI"] == "true"
            ? .deleteOnSuccess
            : .keepAlways
        add(attachment)
    }
}
