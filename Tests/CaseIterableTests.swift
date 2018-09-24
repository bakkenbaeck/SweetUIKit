import XCTest
import SweetUIKit

class CaseIterableTests: XCTestCase {

    // MARK: - Test Enums

    enum ZeroOptions: CaseIterable {}

    enum OneOption: CaseIterable {
        case optionOne
    }

    enum TwoOptions: CaseIterable {
        case optionOne
        case optionTwo
    }

    enum ThreeOptions: CaseIterable {
        case optionOne
        case optionTwo
        case optionThree
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
        XCTAssertEqual(oneArray[0], OneOption.optionOne)

        let twoRaw = TwoOptions.allCases
        let twoArray = TwoOptions.allCasesArray

        XCTAssertEqual(twoRaw.count, twoArray.count)
        XCTAssertEqual(twoArray.count, 2)
        XCTAssertEqual(twoArray[0], TwoOptions.optionOne)
        XCTAssertEqual(twoArray[1], TwoOptions.optionTwo)

        let threeRaw = ThreeOptions.allCases
        let threeArray = ThreeOptions.allCasesArray

        XCTAssertEqual(threeRaw.count, threeArray.count)
        XCTAssertEqual(threeArray.count, 3)
        XCTAssertEqual(threeArray[0], ThreeOptions.optionOne)
        XCTAssertEqual(threeArray[1], ThreeOptions.optionTwo)
        XCTAssertEqual(threeArray[2], ThreeOptions.optionThree)
    }

    func testRequiredValueForIndex() {
        XCTAssertEqual(OneOption.forIndex(0), OneOption.optionOne)

        XCTAssertEqual(TwoOptions.forIndex(0), TwoOptions.optionOne)
        XCTAssertEqual(TwoOptions.forIndex(1), TwoOptions.optionTwo)

        XCTAssertEqual(ThreeOptions.forIndex(0), ThreeOptions.optionOne)
        XCTAssertEqual(ThreeOptions.forIndex(1), ThreeOptions.optionTwo)
        XCTAssertEqual(ThreeOptions.forIndex(2), ThreeOptions.optionThree)
    }

    func testRequiredValueForSection() {
        XCTAssertEqual(OneOption.forSection(at: IndexPath(row: 0, section: 0)), OneOption.optionOne)

        XCTAssertEqual(TwoOptions.forSection(at: IndexPath(row: 0, section: 0)), TwoOptions.optionOne)
        XCTAssertEqual(TwoOptions.forSection(at: IndexPath(row: 0, section: 1)), TwoOptions.optionTwo)

        XCTAssertEqual(ThreeOptions.forSection(at: IndexPath(row: 0, section: 0)), ThreeOptions.optionOne)
        XCTAssertEqual(ThreeOptions.forSection(at: IndexPath(row: 0, section: 1)), ThreeOptions.optionTwo)
        XCTAssertEqual(ThreeOptions.forSection(at: IndexPath(row: 0, section: 2)), ThreeOptions.optionThree)
    }

    func testRequiredValueForRow() {
        XCTAssertEqual(OneOption.forRow(at: IndexPath(row: 0, section: 0)), OneOption.optionOne)

        XCTAssertEqual(TwoOptions.forRow(at: IndexPath(row: 0, section: 0)), TwoOptions.optionOne)
        XCTAssertEqual(TwoOptions.forRow(at: IndexPath(row: 1, section: 0)), TwoOptions.optionTwo)

        XCTAssertEqual(ThreeOptions.forRow(at: IndexPath(row: 0, section: 0)), ThreeOptions.optionOne)
        XCTAssertEqual(ThreeOptions.forRow(at: IndexPath(row: 1, section: 0)), ThreeOptions.optionTwo)
        XCTAssertEqual(ThreeOptions.forRow(at: IndexPath(row: 2, section: 0)), ThreeOptions.optionThree)
    }

    func testRequiredValueForItem() {
        XCTAssertEqual(OneOption.forItem(in: IndexPath(item: 0, section: 0)), OneOption.optionOne)

        XCTAssertEqual(TwoOptions.forItem(in: IndexPath(item: 0, section: 0)), TwoOptions.optionOne)
        XCTAssertEqual(TwoOptions.forItem(in: IndexPath(item: 1, section: 0)), TwoOptions.optionTwo)

        XCTAssertEqual(ThreeOptions.forItem(in: IndexPath(item: 0, section: 0)), ThreeOptions.optionOne)
        XCTAssertEqual(ThreeOptions.forItem(in: IndexPath(item: 1, section: 0)), ThreeOptions.optionTwo)
        XCTAssertEqual(ThreeOptions.forItem(in: IndexPath(item: 2, section: 0)), ThreeOptions.optionThree)
    }

    func testOptionalValueForIndex() {
        XCTAssertNil(ZeroOptions.optionalForIndex(0))

        XCTAssertEqual(OneOption.optionalForIndex(0), OneOption.optionOne)
        XCTAssertNil(OneOption.optionalForIndex(1))

        XCTAssertEqual(TwoOptions.optionalForIndex(0), TwoOptions.optionOne)
        XCTAssertEqual(TwoOptions.optionalForIndex(1), TwoOptions.optionTwo)
        XCTAssertNil(TwoOptions.optionalForIndex(2))

        XCTAssertEqual(ThreeOptions.optionalForIndex(0), ThreeOptions.optionOne)
        XCTAssertEqual(ThreeOptions.optionalForIndex(1), ThreeOptions.optionTwo)
        XCTAssertEqual(ThreeOptions.optionalForIndex(2), ThreeOptions.optionThree)
        XCTAssertNil(ThreeOptions.optionalForIndex(3))
    }

    func testOptionalValueForSection() {
        XCTAssertNil(ZeroOptions.optionalForSection(at: IndexPath(row: 0, section: 0)))

        XCTAssertEqual(OneOption.optionalForSection(at: IndexPath(row: 0, section: 0)), OneOption.optionOne)
        XCTAssertNil(OneOption.optionalForSection(at: IndexPath(row: 0, section: 1)))

        XCTAssertEqual(TwoOptions.optionalForSection(at: IndexPath(row: 0, section: 0)), TwoOptions.optionOne)
        XCTAssertEqual(TwoOptions.optionalForSection(at: IndexPath(row: 0, section: 1)), TwoOptions.optionTwo)
        XCTAssertNil(TwoOptions.optionalForSection(at: IndexPath(row: 0, section: 2)))

        XCTAssertEqual(ThreeOptions.optionalForSection(at: IndexPath(row: 0, section: 0)), ThreeOptions.optionOne)
        XCTAssertEqual(ThreeOptions.optionalForSection(at: IndexPath(row: 0, section: 1)), ThreeOptions.optionTwo)
        XCTAssertEqual(ThreeOptions.optionalForSection(at: IndexPath(row: 0, section: 2)), ThreeOptions.optionThree)
        XCTAssertNil(ThreeOptions.optionalForSection(at: IndexPath(row: 0, section: 3)))
    }

    func testOptionalValueForRow() {
        XCTAssertNil(ZeroOptions.optionalForRow(at: IndexPath(row: 0, section: 0)))

        XCTAssertEqual(OneOption.optionalForRow(at: IndexPath(row: 0, section: 0)), OneOption.optionOne)
        XCTAssertNil(OneOption.optionalForRow(at: IndexPath(row: 1, section: 0)))

        XCTAssertEqual(TwoOptions.optionalForRow(at: IndexPath(row: 0, section: 0)), TwoOptions.optionOne)
        XCTAssertEqual(TwoOptions.optionalForRow(at: IndexPath(row: 1, section: 0)), TwoOptions.optionTwo)
        XCTAssertNil(TwoOptions.optionalForRow(at: IndexPath(row: 2, section: 0)))

        XCTAssertEqual(ThreeOptions.optionalForRow(at: IndexPath(row: 0, section: 0)), ThreeOptions.optionOne)
        XCTAssertEqual(ThreeOptions.optionalForRow(at: IndexPath(row: 1, section: 0)), ThreeOptions.optionTwo)
        XCTAssertEqual(ThreeOptions.optionalForRow(at: IndexPath(row: 2, section: 0)), ThreeOptions.optionThree)
        XCTAssertNil(ThreeOptions.optionalForRow(at: IndexPath(row: 3, section: 0)))
    }

    func testOptionalValueForItem() {
        XCTAssertNil(ZeroOptions.optionalForItem(at: IndexPath(item: 0, section: 0)))

        XCTAssertEqual(OneOption.optionalForItem(at: IndexPath(item: 0, section: 0)), OneOption.optionOne)
        XCTAssertNil(OneOption.optionalForItem(at: IndexPath(item: 1, section: 0)))

        XCTAssertEqual(TwoOptions.optionalForItem(at: IndexPath(item: 0, section: 0)), TwoOptions.optionOne)
        XCTAssertEqual(TwoOptions.optionalForItem(at: IndexPath(item: 1, section: 0)), TwoOptions.optionTwo)
        XCTAssertNil(TwoOptions.optionalForItem(at: IndexPath(item: 2, section: 0)))

        XCTAssertEqual(ThreeOptions.optionalForItem(at: IndexPath(item: 0, section: 0)), ThreeOptions.optionOne)
        XCTAssertEqual(ThreeOptions.optionalForItem(at: IndexPath(item: 1, section: 0)), ThreeOptions.optionTwo)
        XCTAssertEqual(ThreeOptions.optionalForItem(at: IndexPath(item: 2, section: 0)), ThreeOptions.optionThree)
        XCTAssertNil(ThreeOptions.optionalForItem(at: IndexPath(item: 3, section: 0)))
    }
}
