import Foundation

public extension CaseIterable {

    /// Returns the `allCases` static var as an array so it can be accessed based on index.
    static var allCasesArray: [Self] {
        if let asArray = self.allCases as? [Self] {
            return asArray
        } else {
            // The above cast works a lot of the time, but is not guaranteed since it's considered
            // an implementation detail despite the fact that the collection is guaranteed to be in
            // the order of declaration. If it doesn't work, fall back to mapping `allCases` into an array.
            return allCases.map { $0 }
        }
    }

    // MARK: - Non-optional helpers

    /// Gets the enum value at the given index in `allCases`
    ///
    /// NOTE: This method will puke up a fatal error if the given `CaseIterable`
    ///       enum does not contain the given index. use `optionalForIndex(_:)`
    ///       to avoid crashes if the number of items in `allCases` may not be
    ///       known at runtime due to overriding the `allCases` property.
    ///
    /// - Parameter index: The index in the list of cases for which an enum value is desired.
    /// - Returns: The enum value at the given index.
    static func forIndex(_ index: Int) -> Self {
        guard let item = self.optionalForIndex(index) else {
            fatalError("SweetUIKit: Enum \(Self.self) does not contain index \(index)")
        }

        return item
    }

    /// Gets the enum at the index in `allCases` of the `section` of the passed-in `IndexPath`
    ///
    /// NOTE: This method will puke up a fatal error if the given `CaseIterable`
    ///       enum does not contain the given index. use `optionalForSection(at:)` to
    ///       avoid crashes if the number of items in `allCases` may not be
    ///       known at runtime due to overriding the `allCases` property.
    ///
    /// - Parameter index: The indexPath for which you want the `section` property to be used to retrieve the enum value from `allCases`.
    /// - Returns: The enum value at the given index.
    static func forSection(at indexPath: IndexPath) -> Self {
        return forIndex(indexPath.section)
    }

    /// Gets the enum at the index in `allCases` of the `row` of the passed-in `IndexPath`
    ///
    /// NOTE: This method will puke up a fatal error if the given `CaseIterable`
    ///       enum does not contain the given index. use `optionalForItem(at:)` to
    ///       avoid crashes if the number of items in `allCases` may not be
    ///       known at runtime due to overriding the `allCases` property.
    ///
    /// - Parameter index: The indexPath for which you want the `section` property to be used to retrieve the enum value from `allCases`.
    /// - Returns: The enum value at the given index.
    static func forRow(at indexPath: IndexPath) -> Self {
        return forIndex(indexPath.row)
    }

    /// Gets the enum at the index in `allCases` of the `item` of the passed-in `IndexPath`
    ///
    /// NOTE: This method will puke up a fatal error if the given `CaseIterable`
    ///       enum does not contain the given index. use `optionalForItem(at:)` to
    ///       avoid crashes if the number of items in `allCases` may not be
    ///       known at runtime due to overriding the `allCases` property.
    ///
    /// - Parameter index: The indexPath for which you want the `section` property to be used to retrieve the enum value from `allCases`.
    /// - Returns: The enum value at the given index.
    static func forItem(in indexPath: IndexPath) -> Self {
        return forIndex(indexPath.item)
    }

    // MARK: - Optional Helpers

    /// Gets the enum value at the given index in `allCases`
    ///
    /// - Parameter index: The index in the list of cases for which an enum value is desired.
    /// - Returns: The enum value at the given index, or nil if `allCases` does not contain the given index.
    static func optionalForIndex(_ index: Int) -> Self? {
        guard allCasesArray.indices.contains(index) else {
            return nil
        }

        return allCasesArray[index]
    }

    /// Gets the enum at the index in `allCases` of the `section` of the passed-in `IndexPath`
    ///
    /// NOTE: This method will puke up a fatal error if the given `CaseIterable`
    ///       enum does not contain the given index. use `optionalForSection(at:)` to
    ///       avoid crashes if the number of items in `allCases` may not be
    ///       known at runtime due to overriding the `allCases` property.
    ///
    /// - Parameter index: The indexPath for which you want the `section` property to be used to retrieve the enum value from `allCases`.
    /// - Returns: The enum value at the given index, or nil if `allCases` does not contain the given index.
    static func optionalForSection(at indexPath: IndexPath) -> Self? {
        return optionalForIndex(indexPath.section)
    }

    /// Gets the enum at the index in `allCases` of the `row` of the passed-in `IndexPath`
    ///
    /// - Parameter index: The indexPath for which you want the `section` property to be used to retrieve the enum value from `allCases`.
    /// - Returns: The enum value at the given index, or nil if `allCases` does not contain the given index.
    static func optionalForRow(at indexPath: IndexPath) -> Self? {
        return optionalForIndex(indexPath.row)
    }

    /// Gets the enum at the index in `allCases` of the `item` of the passed-in `IndexPath`
    ///
    /// - Parameter index: The indexPath for which you want the `section` property to be used to retrieve the enum value from `allCases`.
    /// - Returns: The enum value at the given index, or nil if `allCases` does not contain the given index.
    static func optionalForItem(at indexPath: IndexPath) -> Self? {
        return optionalForIndex(indexPath.item)
    }
}
