import UIKit
import XCTest
import SweetUIKit

class StringTests: XCTestCase {

    func testWidth() {
        let smallFont = UIFont.systemFont(ofSize: 15)
        let bigFont = UIFont.boldSystemFont(ofSize: 30)

        var string = ""
        XCTAssertEqual(string.width(for: smallFont), 0)
        XCTAssertEqual(string.width(for: bigFont), 0)

        string = "a"
        XCTAssertEqual(floor(string.width(for: smallFont)), 8)
        XCTAssertEqual(floor(string.width(for: bigFont)), 16)

        string = "aa"
        XCTAssertEqual(floor(string.width(for: smallFont)), 16)
        XCTAssertEqual(floor(string.width(for: bigFont)), 33)
    }

    func testHeight() {
        let smallFont = UIFont.systemFont(ofSize: 15)
        let bigFont = UIFont.boldSystemFont(ofSize: 30)
        let width = CGFloat(320)

        var string = ""
        XCTAssertEqual(floor(string.height(for: smallFont, constrainedToWidth: width)), 17)
        XCTAssertEqual(floor(string.height(for: bigFont, constrainedToWidth: width)), 35)

        string = "aa"
        XCTAssertEqual(floor(string.height(for: smallFont, constrainedToWidth: width)), 17)
        XCTAssertEqual(floor(string.height(for: bigFont, constrainedToWidth: width)), 35)

        string = "aa\naa"
        XCTAssertEqual(floor(string.height(for: smallFont, constrainedToWidth: width)), 35)
        XCTAssertEqual(floor(string.height(for: bigFont, constrainedToWidth: width)), 71)
    }
}
