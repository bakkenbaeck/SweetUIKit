import UIKit
import XCTest
import SweetUIKit

class UILabelTests: XCTestCase {

    func testWidth() {
        let label = UILabel(frame: .zero)

        label.text = ""
        XCTAssertEqual(label.width(), 0)

        label.text = "a"

        #if os(iOS)
            XCTAssertEqual(floor(label.width()), 8)
        #else
            XCTAssertEqual(floor(label.width()), 20)
        #endif

        label.font = UIFont.boldSystemFont(ofSize: 30)
        XCTAssertEqual(floor(label.width()), 16)
    }
}
