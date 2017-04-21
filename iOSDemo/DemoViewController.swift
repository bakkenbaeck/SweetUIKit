import Foundation
import UIKit
import SweetUIKit

enum DemoItem: Int {
    case table, edit, collection
    
    static var titles: [String] {
        let allItems: [DemoItem] = [.table, .edit, .collection]
        return allItems.map{ $0.title }
    }
    
    var title: String {
        switch self {
        case .table: return "Table Controller"
        case .edit: return "Edit Controller"
        case .collection: return "Collection Controller"
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .table: return TableController()
        case .edit: return EditViewController()
        case .collection: return CollectionController()
        }
    }
}

class DemoViewController: SweetTableController, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DemoItem.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(TableViewCell.self, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        let itemTitle = DemoItem.titles[indexPath.row]
        cell.titleLabel.text = itemTitle
        
        return cell
    }
}

extension DemoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let item = DemoItem.init(rawValue: indexPath.row) as DemoItem? {
            navigationController?.pushViewController(item.viewController, animated: true)
        }
    }
}
