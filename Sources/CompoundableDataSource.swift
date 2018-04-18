import UIKit

/// A superclass for any data source you wish to be able to combine with other data sources.
///
/// All DataSource and Delegate methods are set to return something that is about as generic as possible.
/// If you don't want the generic, override it. If you think the default behavior is incorrect, open a PR.
///
/// Note that this class is architected so that if you want to use this *without* sticking it in
/// a compound data source, it should work just fine.
open class CompoundableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    /// The table view associated with this data source
    /// NOTE: This is weak to avoid creating a retain cycle by holding on to the tableview.
    open weak var tableView: UITableView?

    public init(tableView: UITableView) {
        self.tableView = tableView
        super.init()

        registerCells(in: tableView)

        tableView.delegate = self
        tableView.dataSource = self
    }

    /// Default implementation does nothing, subclasses should register whatever cells they need to
    /// use in the provided table view.
    ///
    /// - Parameter tableView: tableView
    open func registerCells(in tableView: UITableView) { /* do nothing */ }

    // MARK: - Main Tableview Functions

    open func numberOfSections(in tableView: UITableView) -> Int { return 0 }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 0 }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { return UITableViewCell() }

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { /* do nothing */ }

    // MARK: - Cell sizing

    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat { return UITableViewAutomaticDimension }

    // MARK: - Editing & Deleting

    /// Note that if you want to override this method, you need to also override `editingStyleForRowAt:` to
    /// return the appropriate style, and `commit:` to handle that edit.
    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return false }

    /// Note that if you want to override this method, you need to also override `canEditRowAt:` to
    /// return true, and `commit:` to handle that edit.
    open func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle { return .none }

    /// Note that if you want to override this method, you need to also override `canEditRowAt: `to
    /// return true, and `editingStyleForRowAt:` to make the editing available.
    open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) { /* do nothing */ }

    #if os(iOS)
        open func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? { return nil }

        @available(iOS, introduced: 11)
        open func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? { return nil }

        @available(iOS 11, *)
        open func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? { return nil }

        open func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
            // TODO: Localize
            return "Delete"
        }
    #endif

    // MARK: - Headers and footers

    /// Defaults to nil. Note that if you override this, you must also override `heightForHeaderInSection`
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { return nil }

    /// Defaults to nil. Note that if you override this, you must also override `heightForFooterInSection`
    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? { return nil }

    /// Defaults to nil. Note that if you override this, you must also override `heightForHeaderInSection`
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { return nil }

    /// Defaults to nil. Note that if you override this, you must also override `heightForFooterInSection`
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { return nil }

    /// Defaults to 0. Note that if you want to use either the `titleForFooterInSection:` or
    /// `viewForFooterInSection` methods, you must override this to provide a default height
    /// (usually `UITableViewAutomaticDimension`)
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { return 0 }

    /// Defaults to 0. Note that if you want to use either the `titleForHeaderInSection:` or
    /// `viewForFooterInSection methods, you must override this to provide a default height
    /// (usually `UITableViewAutomaticDimension)
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 0 }
}
