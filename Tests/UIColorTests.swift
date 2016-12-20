import UIKit
import XCTest

class Tests: XCTestCase {
    func testBlackColor() {
        let blackHex = UIColor(hex: "000000")
        let black = UIColor.black

        XCTAssertTrue(blackHex.isEqual(to: black))
    }

    func testRedColor() {
        let redHex = UIColor(hex: "#ff0000")
        let red = UIColor.red

        XCTAssertTrue(redHex.isEqual(to: red))
    }

    func testHexYellowAndiOSYellow() {
        let yellowHex = UIColor(hex: "#ffff00")
        let yellowiOS = UIColor.yellow

        XCTAssertTrue(yellowHex.isEqual(to: yellowiOS))
    }

    func testBlackAndWhiteColor() {
        let whiteHex = UIColor(hex: "FFFFFF")
        let black = UIColor.black

        XCTAssertFalse(whiteHex.isEqual(to: black))
    }

    func testClearColor() {
        let clearColorHex = UIColor(hex: "clearcolor")
        let clear = UIColor.clear

        XCTAssertFalse(clearColorHex.isEqual(to: clear))
    }
}
