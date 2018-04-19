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

        switch bigFont.fontName {
        case ".SFUIDisplay-Semibold":
            // Used on iOS
            XCTAssertEqual(floor(string.width(for: bigFont)), 32)
        case ".SFUIText-Bold":
            // Used on tvOS, is a bit fatter
            XCTAssertEqual(floor(string.width(for: bigFont)), 33)
        default:
            XCTFail("Unexpected default large font: \(bigFont.fontName)")
        }
    }
}
