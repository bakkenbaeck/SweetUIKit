import UIKit

/// A class to allow passing multiple CompoundableDataSource objects into a single table view,
/// then dispatching events to the appropriate sub-source.
public class CompoundDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    private var dataSources: [CompoundableDataSource]
    private weak var tableView: UITableView?

    /// Designated initializer.
    ///
    /// - Parameters:
    ///   - dataSources: An array of data source objects.
    ///   - tableView: The table view you wish to use for display.
    public init(dataSources: [CompoundableDataSource], tableView: UITableView) {
        self.dataSources = dataSources
        self.tableView = tableView
        super.init()

        dataSources.forEach { $0.registerCells(in: tableView) }

        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - Altering contents

    public func append(dataSource: CompoundableDataSource) {
        dataSources.append(dataSource)
        tableView?.reloadData()
    }

    public func removeDataSource(at index: Int) {
        guard dataSources.indices.contains(index) else { /* Nothing at that index */ return }

        dataSources.remove(at: index)
        tableView?.reloadData()
    }

    public func deselectSelectedRow(animated: Bool = true) {
        guard let selectedIndexPath = tableView?.indexPathForSelectedRow else { return }
        tableView?.deselectRow(at: selectedIndexPath, animated: animated)
    }

    // MARK: - Figuring out which data source to use

    private func dataSource(for section: Int) -> CompoundableDataSource {
        return dataSources[section]
    }

    private func dataSource(for compoundIndexPath: IndexPath) -> CompoundableDataSource {
        return dataSource(for: compoundIndexPath.section)
    }

    private func dataSourceIndexPath(for compoundIndexPath: IndexPath) -> IndexPath {
        return IndexPath(row: compoundIndexPath.row, section: 0)
    }

    private func compoundIndexPath(for dataSource: CompoundableDataSource, at dataSourceIndexPath: IndexPath) -> IndexPath? {
        guard let sectionIndex = dataSources.indices.first(where: { dataSources[$0] === dataSource }) else { return nil }

        return IndexPath(row: dataSourceIndexPath.row, section: sectionIndex)
    }

    // MARK: - UITableViewDataSource

    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataSources.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource(for: section)
            .tableView(tableView, numberOfRowsInSection: section)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataSource(for: indexPath)
            .tableView(tableView, cellForRowAt: dataSourceIndexPath(for: indexPath))
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource(for: section)
            .tableView(tableView, titleForHeaderInSection: 0)
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return dataSource(for: section)
            .tableView(tableView, titleForFooterInSection: 0)
    }

    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return dataSource(for: indexPath)
            .tableView(tableView, canEditRowAt: dataSourceIndexPath(for: indexPath))
    }

    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dataSource(for: indexPath)
            .tableView(tableView, commit: editingStyle, forRowAt: dataSourceIndexPath(for: indexPath))
    }

    // MARK: - UITableViewDelegate

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource(for: indexPath)
            .tableView(tableView, didSelectRowAt: dataSourceIndexPath(for: indexPath))
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = dataSource(for: indexPath).tableView(tableView, heightForRowAt: dataSourceIndexPath(for: indexPath))

        return height
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource(for: indexPath)
            .tableView(tableView, estimatedHeightForRowAt: dataSourceIndexPath(for: indexPath))
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return dataSource(for: section)
            .tableView(tableView, heightForHeaderInSection: 0)
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return dataSource(for: section)
            .tableView(tableView, viewForHeaderInSection: 0)
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return dataSource(for: section)
            .tableView(tableView, heightForFooterInSection: 0)
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return dataSource(for: section)
            .tableView(tableView, viewForFooterInSection: 0)
    }

    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return dataSource(for: indexPath)
            .tableView(tableView, editActionsForRowAt: dataSourceIndexPath(for: indexPath))
    }

    @available(iOS 11, *)
    public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return dataSource(for: indexPath)
            .tableView(tableView, leadingSwipeActionsConfigurationForRowAt: dataSourceIndexPath(for: indexPath))
    }

    @available(iOS 11, *)
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return dataSource(for: indexPath)
            .tableView(tableView, trailingSwipeActionsConfigurationForRowAt: dataSourceIndexPath(for: indexPath))
    }

    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return dataSource(for: indexPath)
            .tableView(tableView, editingStyleForRowAt: dataSourceIndexPath(for: indexPath))
    }

    public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return dataSource(for: indexPath)
            .tableView(tableView, titleForDeleteConfirmationButtonForRowAt: dataSourceIndexPath(for: indexPath))
    }
}
