import UIKit

class TableController: SweetTableController {
    let data: [String] = ["Some", "Stringing", "Going", "On"]

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
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath as IndexPath) as! TableViewCell
        cell.textLabel?.text = self.data[indexPath.row]

        return cell
    }
}
