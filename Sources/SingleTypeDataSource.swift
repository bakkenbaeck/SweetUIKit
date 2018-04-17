import UIKit

/// A class which handles displaying a single type of item in a single type of cell in a table view with Generics.
/// Separate from a view controller so it can be used in either a UITableViewController or a tableView within a UIViewController.
///
/// Generic Types:
///  - `CellType` must be some kind of `UITableViewCell` subclass, which will be used to set up registration and dequeueing.
///  - `ItemType` must be an `Equatable`-conforming type.
class SingleTypeDataSource<CellType: UITableViewCell, ItemType: Equatable>: NSObject, SweetTableViewHandling {

    /// The array of items you are displaying with this datasource
    private var items: [ItemType]

    /// The data source being used to display the items.
    /// NOTE: This is weak to avoid creating a retain cycle by holding on to the tableview.
    private weak var tableView: UITableView?

    // MARK: - Public API

    /// Creates a data source with the passed in items and table view, registering the appropriate
    /// cell type for the generic and setting itself as the table view's delegate and data source.
    ///
    /// - Parameters:
    ///   - items: The items to display
    ///   - tableView: The table view you wish to display them in
    public init(items: [ItemType], tableView: UITableView) {
        self.items = items
        self.tableView = tableView
        super.init()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellType.self)
    }

    // MARK: Updating the underlying data

    public func replaceAllItems(with items: [ItemType]) {
        self.items = items
        tableView?.reloadData()
    }

    public func append(item: ItemType) {
        items.append(item)
        tableView?.reloadData()
    }

    public func insert(item: ItemType, at index: Int) {
        items.insert(item, at: index)
        tableView?.reloadData()
    }

    public func remove(item: ItemType) {
        guard let index = items.index(of: item) else { /* item is not in the array */ return }
        removeItem(from: index)
    }

    public func removeItem(from row: Int) {
        guard items.indices.contains(row) else { /* row will be out of bounds */ return }

        items.remove(at: row)
        tableView?.reloadData()
    }

    public func replaceItem(at index: Int, with otherItem: ItemType, animation: UITableViewRowAnimation = .fade) {
        guard items.indices.contains(index) else { /* row will be out of bounds */ return }

        items.insert(otherItem, at: index)

        // Item to replace has been pushed up 1, remove it
        items.remove(at: index + 1)

        let indexPath = IndexPath(row: index, section: 0)
        tableView?.reloadRows(at: [indexPath], with: animation)
    }

    /// Actual cell configuration. This should be overridden by all subclasses.
    ///
    /// - Parameters:
    ///   - cell: The cell to configure
    ///   - item: The item to configure the cell with
    open func configureCell(cell: CellType, for item: ItemType) {
        fatalError("Subclasses must override and not call super")
    }

    /// Selection handling. You must either override this method to handle selections
    /// or set your cell's`selectionStyle` to `.none` to avoid having this called.
    ///
    /// - Parameter item: The selected item.
    open func selected(item: ItemType) {
        fatalError("Subclasses must override and not call super")
    }

    // MARK: - UITableViewDataSource

    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CellType.self, for: indexPath)
        let item = items[indexPath.row]
        configureCell(cell: cell, for: item)
        return cell
    }

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        selected(item: item)
    }
}
