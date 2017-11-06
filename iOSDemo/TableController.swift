import UIKit
import SweetUIKit

class TableController: SweetTableController {
    let data = ["Some", "Stringing", "Going", "On"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(TableViewCell.self)

        tableView.dataSource = self
    }
}

extension TableController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(TableViewCell.self, for: indexPath)
        cell.titleLabel.text = data[indexPath.row]

        return cell
    }
}
