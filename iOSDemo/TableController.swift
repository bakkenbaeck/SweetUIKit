import UIKit
import SweetUIKit

class TableController: SweetTableController {
    let data = ["Some", "Stringing", "Going", "On"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(TableViewCell.self)

        self.tableView.dataSource = self
    }
}

extension TableController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(TableViewCell.self, for: indexPath)
        cell.titleLabel.text = self.data[indexPath.row]

        return cell
    }
}
