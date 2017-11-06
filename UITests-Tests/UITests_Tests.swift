import XCTest

class UITests_Tests: XCTestCase {

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        XCUIApplication().launch()
    }

    func testSampleTest() {
        let cell = XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 4).children(matching: .other).element
        XCTAssertTrue(cell.exists)
    }
}
