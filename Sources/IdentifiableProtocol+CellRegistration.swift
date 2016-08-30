#if os(iOS) || os(tvOS)
import UIKit

public protocol Identifiable {
    static var reuseIdentifier: String { get }
}

public extension Identifiable {
    public static var reuseIdentifier: String {
        get {
            return String(self)
        }
    }
}

extension UITableViewCell: Identifiable {

}

extension UICollectionViewCell: Identifiable {

}

public extension UITableView {
    public func register(cellClass: UITableViewCell.Type) {
        self.registerClass(cellClass.self, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }

    public func registerNib(cellClass: UITableViewCell.Type) {
        self.registerNib(UINib.init(nibName: String(cellClass), bundle: nil), forCellReuseIdentifier: cellClass.reuseIdentifier)
    }
}

public extension UICollectionView {
    public func register(cellClass: UICollectionViewCell.Type) {
        self.registerClass(cellClass.self, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }

    public func registerNib(cellClass: UICollectionViewCell.Type) {
        self.registerNib(UINib.init(nibName: String(cellClass), bundle: nil), forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }
}
#endif
