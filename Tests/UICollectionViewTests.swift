import UIKit
import XCTest
import SweetUIKit

class DataSource: NSObject, UICollectionViewDataSource {
    let numberOfSections: Int
    let numberOfRowsInEachSection: Int

    init(numberOfSections: Int, numberOfRowsInEachSection: Int) {
        self.numberOfSections = numberOfSections
        self.numberOfRowsInEachSection = numberOfRowsInEachSection
    }

    func numberOfSections(in _: UICollectionView) -> Int {
        return numberOfSections
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return numberOfRowsInEachSection
    }

    func collectionView(_: UICollectionView, cellForItemAt _: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension UICollectionView {
    convenience init(dataSource: DataSource) {
        self.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.dataSource = dataSource
    }
}

class UICollectionViewTests: XCTestCase {
    func testIndexPaths() {
        let dataSource = DataSource(numberOfSections: 1, numberOfRowsInEachSection: 1)
        let collectionView = UICollectionView(dataSource: dataSource)
        XCTAssertEqual(collectionView.indexPaths, [IndexPath(item: 0, section: 0)])
    }

    func testNextForEmptyCollectionView() {
        let dataSource = DataSource(numberOfSections: 0, numberOfRowsInEachSection: 0)
        let collectionView = UICollectionView(dataSource: dataSource)
        let nextIndexPath = collectionView.nextIndexPath(to: IndexPath(item: 0, section: 0))
        XCTAssertNil(nextIndexPath)
    }

    func testNextForCollectionViewWithJustOneRow() {
        let dataSource = DataSource(numberOfSections: 1, numberOfRowsInEachSection: 1)
        let collectionView = UICollectionView(dataSource: dataSource)
        let nextIndexPath = collectionView.nextIndexPath(to: IndexPath(item: 0, section: 0))
        XCTAssertNil(nextIndexPath)
    }

    func testNextForIndexPathInTheSameSection() {
        let dataSource = DataSource(numberOfSections: 1, numberOfRowsInEachSection: 2)
        let collectionView = UICollectionView(dataSource: dataSource)
        let nextIndexPath = collectionView.nextIndexPath(to: IndexPath(item: 0, section: 0))
        let expected = IndexPath(item: 1, section: 0)
        XCTAssertEqual(nextIndexPath, expected)
    }

    func testNextForIndexPathInDifferentSections() {
        let dataSource = DataSource(numberOfSections: 2, numberOfRowsInEachSection: 1)
        let collectionView = UICollectionView(dataSource: dataSource)
        let nextIndexPath = collectionView.nextIndexPath(to: IndexPath(item: 0, section: 0))
        let expected = IndexPath(item: 0, section: 1)
        XCTAssertEqual(nextIndexPath, expected)
    }

    func testNextForIndexPathWithOffsetInSameSection() {
        let dataSource = DataSource(numberOfSections: 1, numberOfRowsInEachSection: 3)
        let collectionView = UICollectionView(dataSource: dataSource)
        let nextIndexPath = collectionView.nextIndexPath(to: IndexPath(item: 0, section: 0), offset: 1)
        let expected = IndexPath(item: 2, section: 0)
        XCTAssertEqual(nextIndexPath, expected)
    }

    func testNextForIndexPathWithOffsetInDifferentSection() {
        let dataSource = DataSource(numberOfSections: 2, numberOfRowsInEachSection: 2)
        let collectionView = UICollectionView(dataSource: dataSource)
        let nextIndexPath = collectionView.nextIndexPath(to: IndexPath(item: 0, section: 0), offset: 1)
        let expected = IndexPath(item: 0, section: 1)
        XCTAssertEqual(nextIndexPath, expected)
    }

    func testPreviousForEmptyCollectionView() {
        let dataSource = DataSource(numberOfSections: 0, numberOfRowsInEachSection: 0)
        let collectionView = UICollectionView(dataSource: dataSource)
        let previousIndexPath = collectionView.previousIndexPath(to: IndexPath(item: 0, section: 0))
        XCTAssertNil(previousIndexPath)
    }

    func testPreviousForCollectionViewWithJustOneRow() {
        let dataSource = DataSource(numberOfSections: 1, numberOfRowsInEachSection: 1)
        let collectionView = UICollectionView(dataSource: dataSource)
        let previousIndexPath = collectionView.previousIndexPath(to: IndexPath(item: 0, section: 0))
        XCTAssertNil(previousIndexPath)
    }

    func testPreviousForIndexPathInTheSameSection() {
        let dataSource = DataSource(numberOfSections: 1, numberOfRowsInEachSection: 2)
        let collectionView = UICollectionView(dataSource: dataSource)
        let previousIndexPath = collectionView.previousIndexPath(to: IndexPath(item: 1, section: 0))
        let expected = IndexPath(item: 0, section: 0)
        XCTAssertEqual(previousIndexPath, expected)
    }

    func testPreviousForIndexPathInDifferentSections() {
        let dataSource = DataSource(numberOfSections: 2, numberOfRowsInEachSection: 1)
        let collectionView = UICollectionView(dataSource: dataSource)
        let previousIndexPath = collectionView.previousIndexPath(to: IndexPath(item: 0, section: 1))
        let expected = IndexPath(item: 0, section: 0)
        XCTAssertEqual(previousIndexPath, expected)
    }

    func testPreviousForIndexPathWithOffsetInSameSection() {
        let dataSource = DataSource(numberOfSections: 1, numberOfRowsInEachSection: 3)
        let collectionView = UICollectionView(dataSource: dataSource)
        let previousIndexPath = collectionView.previousIndexPath(to: IndexPath(item: 2, section: 0), offset: 1)
        let expected = IndexPath(item: 0, section: 0)
        XCTAssertEqual(previousIndexPath, expected)
    }

    func testPreviousForIndexPathWithOffsetInDifferentSection() {
        let dataSource = DataSource(numberOfSections: 2, numberOfRowsInEachSection: 2)
        let collectionView = UICollectionView(dataSource: dataSource)
        let previousIndexPath = collectionView.previousIndexPath(to: IndexPath(item: 0, section: 1), offset: 1)
        let expected = IndexPath(item: 0, section: 0)
        XCTAssertEqual(previousIndexPath, expected)
    }
}
