import UIKit
import XCTest
import SweetUIKit

class UIScrollViewTests: XCTestCase {

    func testFrameZero() {
        let scrollView = UIScrollView(frame: .zero)
        XCTAssertTrue(scrollView.isAtTheTop)
        XCTAssertTrue(scrollView.isAtTheBottom)
    }

    func testIsAtTop() {
        let frameWidth = CGFloat(100)
        let frameHeight = CGFloat(100)
        let contentHeight = CGFloat(1000)

        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight))
        scrollView.contentSize = CGSize(width: frameWidth, height: contentHeight)

        XCTAssertTrue(scrollView.isAtTheTop)
        XCTAssertFalse(scrollView.isAtTheBottom)
    }

    func testIsAtBottom() {
        let frameWidth = CGFloat(100)
        let frameHeight = CGFloat(100)
        let contentHeight = CGFloat(1000)

        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight))
        scrollView.contentSize = CGSize(width: frameWidth, height: contentHeight)
        scrollView.contentOffset = CGPoint(x: 0, y: contentHeight)

        XCTAssertFalse(scrollView.isAtTheTop)
        XCTAssertTrue(scrollView.isAtTheBottom)
    }
}
