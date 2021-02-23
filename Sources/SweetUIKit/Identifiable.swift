import UIKit

public protocol Identifiable {
    static var reuseIdentifier: String { get }
}

public extension Identifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Identifiable {
}

extension UITableViewHeaderFooterView: Identifiable {
}

extension UICollectionReusableView: Identifiable {
}
