import Foundation
import UIKit
import SweetUIKit

enum DemoItem: CaseIterable {
    case edit
    case collection
    case searchableCollection
    case caseIterable

    var title: String {
        switch self {
        case .edit: return "Edit Controller"
        case .collection: return "Collection Controller"
        case .searchableCollection: return "Searchable Collection Controller"
        case .caseIterable: return "CaseIterable Controller"
        }
    }

    var viewController: UIViewController {
        switch self {
        case .edit: return EditViewController()
        case .collection: return CollectionController()
        case .searchableCollection: return SearchableCollectionViewController()
        case .caseIterable: return CaseIterableViewController()
        }
    }
}

class DemoViewController: SweetTableController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(TableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension DemoViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DemoItem.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(TableViewCell.self, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        let itemTitle = DemoItem.forRow(at: indexPath).title
        cell.titleLabel.text = itemTitle

        return cell
    }
}

extension DemoViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let item = DemoItem.optionalForRow(at: indexPath) {
            navigationController?.pushViewController(item.viewController, animated: true)
        }
    }
}
