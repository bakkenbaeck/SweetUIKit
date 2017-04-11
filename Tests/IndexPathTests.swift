import UIKit
import XCTest
import SweetUIKit

class IndexPathTests: XCTestCase {

    func testPositionComparison() {
        let firstPath = IndexPath(row: 0, section: 0)
        let secondPath = IndexPath(row: 1, section: 0)
        let thirdPath = IndexPath(row: 0, section: 1)
        let fourthPath = IndexPath(row: 1, section: 1)

        XCTAssert(firstPath.comparePosition(to: firstPath) == .same)
        XCTAssert(firstPath.comparePosition(to: secondPath) == .before)
        XCTAssert(firstPath.comparePosition(to: thirdPath) == .before)
        XCTAssert(firstPath.comparePosition(to: fourthPath) == .before)

        XCTAssert(secondPath.comparePosition(to: firstPath) == .ahead)
        XCTAssert(secondPath.comparePosition(to: secondPath) == .same)
        XCTAssert(secondPath.comparePosition(to: thirdPath) == .before)
        XCTAssert(secondPath.comparePosition(to: fourthPath) == .before)

        XCTAssert(thirdPath.comparePosition(to: firstPath) == .ahead)
        XCTAssert(thirdPath.comparePosition(to: secondPath) == .ahead)
        XCTAssert(thirdPath.comparePosition(to: thirdPath) == .same)
        XCTAssert(thirdPath.comparePosition(to: fourthPath) == .before)

        XCTAssert(fourthPath.comparePosition(to: firstPath) == .ahead)
        XCTAssert(fourthPath.comparePosition(to: secondPath) == .ahead)
        XCTAssert(fourthPath.comparePosition(to: thirdPath) == .ahead)
        XCTAssert(fourthPath.comparePosition(to: fourthPath) == .same)
    }
}
