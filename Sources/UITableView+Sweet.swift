#if os(iOS) || os(tvOS)
    import UIKit

    public extension UITableView {
        public func register(_ cellClass: UITableViewCell.Type) {
            self.register(cellClass.self, forCellReuseIdentifier: cellClass.reuseIdentifier)
        }

        public func registerNib(_ cellClass: UITableViewCell.Type) {
            self.register(UINib.init(nibName: String(describing: cellClass), bundle: nil), forCellReuseIdentifier: cellClass.reuseIdentifier)
        }

        public func registerHeaderFooter(_ viewClass: UITableViewHeaderFooterView.Type) {
            self.register(viewClass.self, forHeaderFooterViewReuseIdentifier: viewClass.reuseIdentifier)
        }

        public func dequeue<T where T: Identifiable, T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
            return self.dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier, for: indexPath) as! T
        }
    }
#endif
