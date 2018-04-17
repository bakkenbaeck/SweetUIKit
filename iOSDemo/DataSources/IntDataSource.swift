import SweetUIKit
import UIKit

class IntDataSource: SingleTypeDataSource<IntCell, Int> {
    private let title: String

    init(tableView: UITableView, selectionAction: @escaping (Int) -> Void, title: String) {
        self.title = title
        super.init(items: [
            11,
            22,
            33,
            44,
            55,
            66,
        ],
        tableView: tableView,
        selectionAction: selectionAction)
    }

    func printSelected(integer: Int) {
        if shouldBeTiny(integer: integer) {
            print("selected \(integer)")
        } else {
            print("SELECTED \(integer)")
        }
    }

    private func shouldBeTiny(integer: Int) -> Bool {
        return integer % 2 == 0
    }

    override func configureCell(cell: IntCell, for item: Int) {
        if shouldBeTiny(integer: item) {
            cell.titleLabel.text = "tiny even: \(item)"
            cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 10)

        } else {
            cell.titleLabel.text = "GIANT ODD: \(item)"
            cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if shouldBeTiny(integer: item(at: indexPath)) {
            return 20
        } else {
            return 100
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return title
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
}
