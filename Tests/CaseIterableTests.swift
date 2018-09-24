import XCTest
import SweetUIKit

class CaseIterableTests: XCTestCase {

    // MARK: - Test Enums

    enum ZeroOptions: CaseIterable {}

    enum OneOption: CaseIterable {
        case first
    }

    enum TwoOptions: CaseIterable {
        case first
        case second
    }

    enum ThreeOptions: CaseIterable {
        case first
        case second
        case third
    }

    // MARK: - Tests

    func testAllCasesArrayHasCorrectItemsInOrder() {
        let zeroRaw = ZeroOptions.allCases
        let zeroArray = ZeroOptions.allCasesArray

        XCTAssertEqual(zeroRaw.count, zeroArray.count)
        XCTAssertEqual(zeroArray.count, 0)

        let oneRaw = OneOption.allCases
        let oneArray = OneOption.allCasesArray

        XCTAssertEqual(oneRaw.count, oneArray.count)
        XCTAssertEqual(oneArray.count, 1)
        XCTAssertEqual(oneArray[0], OneOption.first)

        let twoRaw = TwoOptions.allCases
        let twoArray = TwoOptions.allCasesArray

        XCTAssertEqual(twoRaw.count, twoArray.count)
        XCTAssertEqual(twoArray.count, 2)
        XCTAssertEqual(twoArray[0], TwoOptions.first)
        XCTAssertEqual(twoArray[1], TwoOptions.second)

        let threeRaw = ThreeOptions.allCases
        let threeArray = ThreeOptions.allCasesArray

        XCTAssertEqual(threeRaw.count, threeArray.count)
        XCTAssertEqual(threeArray.count, 3)
        XCTAssertEqual(threeArray[0], ThreeOptions.first)
        XCTAssertEqual(threeArray[1], ThreeOptions.second)
        XCTAssertEqual(threeArray[2], ThreeOptions.third)
    }

    func testRequiredValueForIndex() {
        XCTAssertEqual(OneOption.forIndex(0), OneOption.first)

        XCTAssertEqual(TwoOptions.forIndex(0), TwoOptions.first)
        XCTAssertEqual(TwoOptions.forIndex(1), TwoOptions.second)

        XCTAssertEqual(ThreeOptions.forIndex(0), ThreeOptions.first)
        XCTAssertEqual(ThreeOptions.forIndex(1), ThreeOptions.second)
        XCTAssertEqual(ThreeOptions.forIndex(2), ThreeOptions.third)
    }

    func testRequiredValueForSection() {
        XCTAssertEqual(OneOption.forSection(at: IndexPath(row: 0, section: 0)), OneOption.first)

        XCTAssertEqual(TwoOptions.forSection(at: IndexPath(row: 0, section: 0)), TwoOptions.first)
        XCTAssertEqual(TwoOptions.forSection(at: IndexPath(row: 0, section: 1)), TwoOptions.second)

        XCTAssertEqual(ThreeOptions.forSection(at: IndexPath(row: 0, section: 0)), ThreeOptions.first)
        XCTAssertEqual(ThreeOptions.forSection(at: IndexPath(row: 0, section: 1)), ThreeOptions.second)
        XCTAssertEqual(ThreeOptions.forSection(at: IndexPath(row: 0, section: 2)), ThreeOptions.third)
    }

    func testRequiredValueForRow() {
        XCTAssertEqual(OneOption.forRow(at: IndexPath(row: 0, section: 0)), OneOption.first)

        XCTAssertEqual(TwoOptions.forRow(at: IndexPath(row: 0, section: 0)), TwoOptions.first)
        XCTAssertEqual(TwoOptions.forRow(at: IndexPath(row: 1, section: 0)), TwoOptions.second)

        XCTAssertEqual(ThreeOptions.forRow(at: IndexPath(row: 0, section: 0)), ThreeOptions.first)
        XCTAssertEqual(ThreeOptions.forRow(at: IndexPath(row: 1, section: 0)), ThreeOptions.second)
        XCTAssertEqual(ThreeOptions.forRow(at: IndexPath(row: 2, section: 0)), ThreeOptions.third)
    }

    func testRequiredValueForItem() {
        XCTAssertEqual(OneOption.forItem(in: IndexPath(item: 0, section: 0)), OneOption.first)

        XCTAssertEqual(TwoOptions.forItem(in: IndexPath(item: 0, section: 0)), TwoOptions.first)
        XCTAssertEqual(TwoOptions.forItem(in: IndexPath(item: 1, section: 0)), TwoOptions.second)

        XCTAssertEqual(ThreeOptions.forItem(in: IndexPath(item: 0, section: 0)), ThreeOptions.first)
        XCTAssertEqual(ThreeOptions.forItem(in: IndexPath(item: 1, section: 0)), ThreeOptions.second)
        XCTAssertEqual(ThreeOptions.forItem(in: IndexPath(item: 2, section: 0)), ThreeOptions.third)
    }

    func testOptionalValueForIndex() {
        XCTAssertNil(ZeroOptions.optionalForIndex(0))

        XCTAssertEqual(OneOption.optionalForIndex(0), OneOption.first)
        XCTAssertNil(OneOption.optionalForIndex(1))

        XCTAssertEqual(TwoOptions.optionalForIndex(0), TwoOptions.first)
        XCTAssertEqual(TwoOptions.optionalForIndex(1), TwoOptions.second)
        XCTAssertNil(TwoOptions.optionalForIndex(2))

        XCTAssertEqual(ThreeOptions.optionalForIndex(0), ThreeOptions.first)
        XCTAssertEqual(ThreeOptions.optionalForIndex(1), ThreeOptions.second)
        XCTAssertEqual(ThreeOptions.optionalForIndex(2), ThreeOptions.third)
        XCTAssertNil(ThreeOptions.optionalForIndex(3))
    }

    func testOptionalValueForSection() {
        XCTAssertNil(ZeroOptions.optionalForSection(at: IndexPath(row: 0, section: 0)))

        XCTAssertEqual(OneOption.optionalForSection(at: IndexPath(row: 0, section: 0)), OneOption.first)
        XCTAssertNil(OneOption.optionalForSection(at: IndexPath(row: 0, section: 1)))

        XCTAssertEqual(TwoOptions.optionalForSection(at: IndexPath(row: 0, section: 0)), TwoOptions.first)
        XCTAssertEqual(TwoOptions.optionalForSection(at: IndexPath(row: 0, section: 1)), TwoOptions.second)
        XCTAssertNil(TwoOptions.optionalForSection(at: IndexPath(row: 0, section: 2)))

        XCTAssertEqual(ThreeOptions.optionalForSection(at: IndexPath(row: 0, section: 0)), ThreeOptions.first)
        XCTAssertEqual(ThreeOptions.optionalForSection(at: IndexPath(row: 0, section: 1)), ThreeOptions.second)
        XCTAssertEqual(ThreeOptions.optionalForSection(at: IndexPath(row: 0, section: 2)), ThreeOptions.third)
        XCTAssertNil(ThreeOptions.optionalForSection(at: IndexPath(row: 0, section: 3)))
    }

    func testOptionalValueForRow() {
        XCTAssertNil(ZeroOptions.optionalForRow(at: IndexPath(row: 0, section: 0)))

        XCTAssertEqual(OneOption.optionalForRow(at: IndexPath(row: 0, section: 0)), OneOption.first)
        XCTAssertNil(OneOption.optionalForRow(at: IndexPath(row: 1, section: 0)))

        XCTAssertEqual(TwoOptions.optionalForRow(at: IndexPath(row: 0, section: 0)), TwoOptions.first)
        XCTAssertEqual(TwoOptions.optionalForRow(at: IndexPath(row: 1, section: 0)), TwoOptions.second)
        XCTAssertNil(TwoOptions.optionalForRow(at: IndexPath(row: 2, section: 0)))

        XCTAssertEqual(ThreeOptions.optionalForRow(at: IndexPath(row: 0, section: 0)), ThreeOptions.first)
        XCTAssertEqual(ThreeOptions.optionalForRow(at: IndexPath(row: 1, section: 0)), ThreeOptions.second)
        XCTAssertEqual(ThreeOptions.optionalForRow(at: IndexPath(row: 2, section: 0)), ThreeOptions.third)
        XCTAssertNil(ThreeOptions.optionalForRow(at: IndexPath(row: 3, section: 0)))
    }

    func testOptionalValueForItem() {
        XCTAssertNil(ZeroOptions.optionalForItem(at: IndexPath(item: 0, section: 0)))

        XCTAssertEqual(OneOption.optionalForItem(at: IndexPath(item: 0, section: 0)), OneOption.first)
        XCTAssertNil(OneOption.optionalForItem(at: IndexPath(item: 1, section: 0)))

        XCTAssertEqual(TwoOptions.optionalForItem(at: IndexPath(item: 0, section: 0)), TwoOptions.first)
        XCTAssertEqual(TwoOptions.optionalForItem(at: IndexPath(item: 1, section: 0)), TwoOptions.second)
        XCTAssertNil(TwoOptions.optionalForItem(at: IndexPath(item: 2, section: 0)))

        XCTAssertEqual(ThreeOptions.optionalForItem(at: IndexPath(item: 0, section: 0)), ThreeOptions.first)
        XCTAssertEqual(ThreeOptions.optionalForItem(at: IndexPath(item: 1, section: 0)), ThreeOptions.second)
        XCTAssertEqual(ThreeOptions.optionalForItem(at: IndexPath(item: 2, section: 0)), ThreeOptions.third)
        XCTAssertNil(ThreeOptions.optionalForItem(at: IndexPath(item: 3, section: 0)))
    }
}
