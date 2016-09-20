import UIKit
import XCTest

class UILabelTests: XCTestCase {
    func testWidth() {
        let label = UILabel(frame: .zero)

        label.text = ""
        XCTAssertEqual(label.width(), 0)

        label.text = "a"
        XCTAssertEqual(floor(label.width()), 8)

        label.font = UIFont.boldSystemFont(ofSize: 30)
        XCTAssertEqual(floor(label.width()), 16)
    }
}
