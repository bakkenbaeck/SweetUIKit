import UIKit

/// A class which handles displaying a single type of item in a single type of cell in a table view with Generics.
/// Separate from a view controller so it can be used in either a UITableViewController or a tableView within a UIViewController.
///
/// Generic Types:
///  - `CellType` must be some kind of `UITableViewCell` subclass, which will be used to set up registration and dequeueing.
///  - `ItemType` must be an `Equatable`-conforming type.
open class SingleTypeDataSource<CellType: UITableViewCell, ItemType: Equatable>: CompoundableDataSource {

    /// The array of items you are displaying with this datasource
    private var items: [ItemType]

    private let selectionAction: (ItemType) -> Void

    // MARK: - Public API

    /// Creates a data source with the passed in items and table view, registering the appropriate
    /// cell type for the generic and setting itself as the table view's delegate and data source.
    ///
    /// - Parameters:
    ///   - items: The items to display
    ///   - tableView: The table view you wish to display them in
    ///   - selectionAction: The action to fire when a cell is selected
    ///                      - Parameter is the item selected
    public init(items: [ItemType], tableView: UITableView, selectionAction: @escaping (ItemType) -> Void) {
        self.items = items
        self.selectionAction = selectionAction
        super.init(tableView: tableView)
    }

    public func item(at indexPath: IndexPath) -> ItemType {
        return items[indexPath.row]
    }

    public var itemCount: Int {
        return items.count
    }

    // MARK: Updating the underlying data

    public func replaceAllItems(with items: [ItemType]) {
        self.items = items
        reloadData()
    }

    public func append(item: ItemType) {
        items.append(item)

        // We can force unwrap since we definitely just added an item
        let lastIndex = items.indices.last!
        insertRowsAtIndexPaths([IndexPath(row: lastIndex, section: 0)])
    }

    public func insert(item: ItemType, at index: Int) {
        items.insert(item, at: index)
        insertRowsAtIndexPaths([IndexPath(row: index, section: 0)])
    }

    public func remove(item: ItemType) {
        guard let index = items.index(of: item) else { /* item is not in the array */ return }
        removeItem(from: index)
    }

    public func removeItem(from row: Int) {
        guard items.indices.contains(row) else { /* row will be out of bounds */ return }

        items.remove(at: row)
        let removedIndexPath = IndexPath(row: row, section: 0)
        deleteRowsAtIndexPaths([removedIndexPath])
    }

    public func replaceItem(at index: Int, with otherItem: ItemType, animation: UITableViewRowAnimation = .automatic) {
        guard items.indices.contains(index) else { /* row will be out of bounds */ return }

        items.insert(otherItem, at: index)

        // Item to replace has been pushed up 1, remove it
        items.remove(at: index + 1)

        let indexPath = IndexPath(row: index, section: 0)
        reloadRowsAtIndexPaths([indexPath], with: animation)
    }

    /// Actual cell configuration. This should be overridden by all subclasses.
    ///
    /// - Parameters:
    ///   - cell: The cell to configure
    ///   - item: The item to configure the cell with
    open func configureCell(cell: CellType, for item: ItemType) {
        fatalError("Subclasses must override and not call super")
    }

    // MARK: - CompoundDataSource overrides

    open override func registerCells(in tableView: UITableView) {
        tableView.register(CellType.self)
    }

    open override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CellType.self, for: indexPath)
        let itemForRow = item(at: indexPath)
        configureCell(cell: cell, for: itemForRow)
        return cell
    }

    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionAction(item(at: indexPath))
    }
}
