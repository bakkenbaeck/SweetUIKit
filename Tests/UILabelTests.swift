import UIKit
import XCTest

class UILabelTests: XCTestCase {
    func testWidth() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
        label.text = "Hi mom"
        XCTAssertEqual(label.width(), 199)
    }
}
