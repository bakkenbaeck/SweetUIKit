#if os(iOS) || os(tvOS)
import UIKit

public protocol Identifiable {
    static var reuseIdentifier: String { get }
}

public extension Identifiable {
    public static var reuseIdentifier: String {
        get {
            return String(describing: self)
        }
    }
}

extension UITableViewCell: Identifiable {

}

extension UICollectionViewCell: Identifiable {

}

extension UITableViewHeaderFooterView: Identifiable {

}

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
    
    public func dequeue<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as! T
    }    
}

public extension UICollectionView {
    public func register(_ cellClass: UICollectionViewCell.Type) {
        self.register(cellClass.self, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }

    public func registerNib(_ cellClass: UICollectionViewCell.Type) {
        self.register(UINib.init(nibName: String(describing: cellClass), bundle: nil), forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }
}
#endif
