//
//  InfosysAssignmentUITests.swift
//  InfosysAssignmentUITests
//
//  Created by Balaji S on 23/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import XCTest

class InfosysAssignmentUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }

    func testTableViewScrolling() {
        app.launch()
        // This is to check the tableview is scrolling smoothly without crashing
        app.swipeUp()
        app.swipeDown()
    }

    func testTableViewCellSelection() {
        app.launch()
        // This is to test on selection of a tableviewcell its not suppose to crash
        app.tables.cells.element(boundBy: 5).tap()
        Thread.sleep(forTimeInterval: 1)
    }

    func testPullToRefresh() {
        app.launch()
        // This is to test pull to refresh feature
        let firstCell = app.tables.cells.firstMatch
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 4))
        start.press(forDuration: 0, thenDragTo: finish)
    }

    func testOrientationChange() {
        app.launch()
        // This is to test orientation change
        XCUIDevice.shared.orientation = .landscapeLeft
        Thread.sleep(forTimeInterval: 1)
        app.swipeUp()
        Thread.sleep(forTimeInterval: 1)
        XCUIDevice.shared.orientation = .portrait
        app.swipeDown()
    }

}
