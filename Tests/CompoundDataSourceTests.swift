import SweetUIKit
import UIKit
import XCTest

@testable import iOSDemo

class CompoundDataSourceTests: XCTestCase {

    private let tableView = UITableView()

    private var expectedInt: Int?
    private let testIntSourceTitle = "Test Int Data Source"
    private let defaultIntCount = 6
    private let intSourceIndex = 0
    private lazy var intSource: IntDataSource = {
        return IntDataSource(tableView: tableView,
                             selectionAction: { result in
                                 guard let expected = self.expectedInt else { return }
                                 self.checkResult(result, expected: expected)
                             },
                             title: testIntSourceTitle)
    }()

    private var expectedString: String?
    private let testStringSourceTitle = "Test String Data Source"
    private let defaultStringCount = 7
    private let stringSourceIndex = 1
    private lazy var stringSource: StringDataSource = {
        return StringDataSource(tableView: tableView,
                                selectionAction: { result in
                                    guard let expected = self.expectedString else { return }
                                    self.checkResult(result, expected: expected)
                                },
                                title: testStringSourceTitle)
    }()

    private var compoundSource: CompoundDataSource!

    private var expectation: XCTestExpectation?
    private func checkResult<T: Equatable>(_ result: T,
                                           expected: T,
                                           file: StaticString = #file,
                                           line: UInt = #line) {
        XCTAssertEqual(result, expected, file: file, line: line)
        expectation?.fulfill()
    }

    // MARK: - Setup/Teardown

    override func setUp() {
        super.setUp()

        compoundSource = CompoundDataSource(dataSources: [
            intSource,
            stringSource,
        ], tableView: tableView)
    }

    override func tearDown() {
        expectedInt = nil
        expectedString = nil
        expectation = nil
        super.tearDown()
    }

    // MARK: - Actual Tests

    func testTwoDataSourcesCreatesProperRowAndSectionCounts() {
        XCTAssertEqual(intSource.numberOfSections(in: tableView), 1)
        XCTAssertEqual(stringSource.numberOfSections(in: tableView), 1)
        XCTAssertEqual(compoundSource.numberOfSections(in: tableView), 2)

        XCTAssertEqual(intSource.tableView(tableView, numberOfRowsInSection: 0), defaultIntCount)
        XCTAssertEqual(compoundSource.tableView(tableView, numberOfRowsInSection: intSourceIndex), defaultIntCount)

        XCTAssertEqual(stringSource.tableView(tableView, numberOfRowsInSection: 0), defaultStringCount)
        XCTAssertEqual(compoundSource.tableView(tableView, numberOfRowsInSection: stringSourceIndex), defaultStringCount)
    }

    func testDataSourcesHaveCorrectHeaderAndFooterTitlesAndViews() {
        XCTAssertEqual(compoundSource.tableView(tableView, titleForHeaderInSection: intSourceIndex), testIntSourceTitle)
        XCTAssertEqual(compoundSource.tableView(tableView, titleForHeaderInSection: stringSourceIndex), testStringSourceTitle)

        let footerTitleForStringSection = "I'm a custom footer!"
        XCTAssertNil(compoundSource.tableView(tableView, titleForFooterInSection: intSourceIndex))
        XCTAssertEqual(compoundSource.tableView(tableView, titleForFooterInSection: stringSourceIndex), footerTitleForStringSection)

        XCTAssertEqual(compoundSource.tableView(tableView, heightForFooterInSection: stringSourceIndex), UITableViewAutomaticDimension)
        XCTAssertEqual(compoundSource.tableView(tableView, heightForFooterInSection: intSourceIndex), 0)

        guard let footerLabel = compoundSource.tableView(tableView, viewForFooterInSection: stringSourceIndex) as? UILabel else {
            XCTFail("This is not my beautiful footer label!")
            return
        }

        XCTAssertEqual(footerLabel.text, footerTitleForStringSection)
        XCTAssertNil(compoundSource.tableView(tableView, viewForFooterInSection: intSourceIndex))
    }

    func testRemovingADataSourceUpdatesRowAndSectionCounts() {
        XCTAssertEqual(compoundSource.numberOfSections(in: tableView), 2)

        compoundSource.removeDataSource(at: 0)

        XCTAssertEqual(compoundSource.numberOfSections(in: tableView), 1)
        let updatedStringSourceIndex = stringSourceIndex - 1
        XCTAssertEqual(updatedStringSourceIndex, 0)
        XCTAssertEqual(compoundSource.tableView(tableView, numberOfRowsInSection: updatedStringSourceIndex), defaultStringCount)
    }

    func testAddingSomethingToACompoundedDataSourceUpdatesCountsAndReturnsNewCell() {
        XCTAssertEqual(compoundSource.tableView(tableView, numberOfRowsInSection: intSourceIndex), defaultIntCount)

        intSource.insert(item: 77, at: 3)

        XCTAssertEqual(compoundSource.tableView(tableView, numberOfRowsInSection: intSourceIndex), (defaultIntCount + 1))
        let cell = compoundSource.tableView(tableView, cellForRowAt: IndexPath(row: 3, section: intSourceIndex))

        guard let typedCell = cell as? IntCell else {
            XCTFail("Returned cell was not the proper cell")
            return
        }

        XCTAssertEqual(typedCell.titleLabel.text, "GIANT ODD: 77")
    }

    func testSelectingRowWorksProperly() {
        let intExpectation = XCTestExpectation(description: "Selected int expectation")
        expectation = intExpectation
        expectedInt = 55

        compoundSource.tableView(tableView, didSelectRowAt: IndexPath(row: 4, section: intSourceIndex))

        wait(for: [intExpectation], timeout: 2)

        let stringExpectation = XCTestExpectation(description: "Selected string expectation")
        expectation = stringExpectation
        expectedString = "Out"

        compoundSource.tableView(tableView, didSelectRowAt: IndexPath(row: 1, section: stringSourceIndex))

        wait(for: [stringExpectation], timeout: 2)
    }

    func testFetchingEditFunctionsWorksProperly() {
        let stringSectionRow = IndexPath(row: 0, section: stringSourceIndex)
        XCTAssertFalse(compoundSource.tableView(tableView, canEditRowAt: stringSectionRow))

        XCTAssertNil(compoundSource.tableView(tableView, editActionsForRowAt: stringSectionRow))

        XCTAssertEqual(compoundSource.tableView(tableView, editingStyleForRowAt: stringSectionRow), .none)
        XCTAssertEqual(compoundSource.tableView(tableView, titleForDeleteConfirmationButtonForRowAt: stringSectionRow), "Delete")

        let intSectionRow = IndexPath(row: 0, section: intSourceIndex)
        XCTAssertTrue(compoundSource.tableView(tableView, canEditRowAt: intSectionRow))

        XCTAssertEqual(compoundSource.tableView(tableView, editingStyleForRowAt: intSectionRow), .delete)
        XCTAssertEqual(compoundSource.tableView(tableView, titleForDeleteConfirmationButtonForRowAt: intSectionRow), "Delete")

        // This is NOT overridden so it should still be nil
        XCTAssertNil(compoundSource.tableView(tableView, editActionsForRowAt: intSectionRow))

        if #available(iOS 11, *) {
            // None of these are overridden in either data source.
            XCTAssertNil(compoundSource.tableView(tableView, leadingSwipeActionsConfigurationForRowAt: stringSectionRow))
            XCTAssertNil(compoundSource.tableView(tableView, trailingSwipeActionsConfigurationForRowAt: stringSectionRow))

            XCTAssertNil(compoundSource.tableView(tableView, leadingSwipeActionsConfigurationForRowAt: intSectionRow))
            XCTAssertNil(compoundSource.tableView(tableView, trailingSwipeActionsConfigurationForRowAt: intSectionRow))
        }
    }

    func testDeletingWorksProperly() {
        let shouldNotChange = IndexPath(row: 0, section: stringSourceIndex)
        let shouldChange = IndexPath(row: 0, section: intSourceIndex)

        compoundSource.tableView(tableView, commit: .delete, forRowAt: shouldNotChange)

        XCTAssertEqual(compoundSource.tableView(tableView, numberOfRowsInSection: stringSourceIndex), defaultStringCount)

        compoundSource.tableView(tableView, commit: .delete, forRowAt: shouldChange)
        XCTAssertEqual(compoundSource.tableView(tableView, numberOfRowsInSection: intSourceIndex), (defaultIntCount - 1))
    }
}
