import UIKit

class TableViewController: SweetTableViewController {
    lazy var data: [String] = {
        return ["Some", "Stringing", "Going", "On"]
    }()

    override init(with tableViewStyle: UITableViewStyle = .Plain) {
        super.init(with: tableViewStyle)

        self.tableView.register(TableViewCell)

        self.tableView.dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("!")
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCell.reuseIdentifier, forIndexPath: indexPath) as! TableViewCell
        cell.textLabel?.text = self.data[indexPath.row]

        return cell
    }
}
