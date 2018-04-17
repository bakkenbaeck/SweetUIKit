import UIKit
import SweetUIKit

class StringDataSource: SingleTypeDataSource<TableViewCell, String> {

    private let title: String?

    init(tableView: UITableView,
         selectionAction: @escaping (String) -> Void,
         title: String? = nil) {
        self.title = title
        super.init(items: [
            "Checking",
            "Out",
            "Generic",
            "And",
            "Compounding",
            "Data",
            "Sources",
        ],
        tableView: tableView,
        selectionAction: selectionAction)
    }

    override func configureCell(cell: TableViewCell, for item: String) {
        cell.titleLabel.text = item
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if title != nil {
            return UITableViewAutomaticDimension
        } else {
            return super.tableView(tableView, heightForHeaderInSection: section)
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return title
    }
}
