import UIKit

public protocol Identifiable {
    static var identifier: String { get }
}

public extension Identifiable {
    static var identifier: String {
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
    func register(cellClass: UITableViewCell.Type) {
        self.registerClass(cellClass.self, forCellReuseIdentifier: cellClass.identifier)
    }
}

public extension UICollectionView {
    func register(cellClass: UICollectionViewCell.Type) {
        self.registerClass(cellClass.self, forCellWithReuseIdentifier: cellClass.identifier)
    }
}
