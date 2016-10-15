import UIKit
import XCTest

class UIScrollViewTests: XCTestCase {
    func testFrameZero() {
        let scrollView = UIScrollView(frame: .zero)
        XCTAssertTrue(scrollView.isAtTop)
        XCTAssertTrue(scrollView.isAtBottom)
    }

    func testIsAtTop() {
        let frameWidth = CGFloat(100)
        let frameHeight = CGFloat(100)
        let contentHeight = CGFloat(1000)

        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight))
        scrollView.contentSize = CGSize(width: frameWidth, height: contentHeight)

        XCTAssertTrue(scrollView.isAtTop)
        XCTAssertFalse(scrollView.isAtBottom)
    }

    func testIsAtBottom() {
        let frameWidth = CGFloat(100)
        let frameHeight = CGFloat(100)
        let contentHeight = CGFloat(1000)

        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight))
        scrollView.contentSize = CGSize(width: frameWidth, height: contentHeight)
        scrollView.contentOffset = CGPoint(x: 0, y: contentHeight)

        XCTAssertFalse(scrollView.isAtTop)
        XCTAssertTrue(scrollView.isAtBottom)
    }
}
