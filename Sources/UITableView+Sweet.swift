import UIKit

public extension UITableView {

    public func register(_ cellClass: UITableViewCell.Type) {
        register(cellClass.self, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }

    public func registerNib(_ cellClass: UITableViewCell.Type) {
        register(UINib(nibName: String(describing: cellClass), bundle: nil), forCellReuseIdentifier: cellClass.reuseIdentifier)
    }

    public func registerHeaderFooter(_ viewClass: UITableViewHeaderFooterView.Type) {
        register(viewClass.self, forHeaderFooterViewReuseIdentifier: viewClass.reuseIdentifier)
    }

    public func dequeue<T>(_ cellClass: T.Type, for indexPath: IndexPath) -> T where T: UITableViewCell {
        return dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier, for: indexPath) as! T
    }

    public func dequeue<T: UITableViewCell>(_ cellClass: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier) as! T
    }
}
