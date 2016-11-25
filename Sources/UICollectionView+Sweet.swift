#if os(iOS) || os(tvOS)
    import UIKit

    public extension UICollectionView {

        public func register(_ cellClass: UICollectionViewCell.Type) {
            self.register(cellClass.self, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        }

        public func registerNib(_ cellClass: UICollectionViewCell.Type) {
            self.register(UINib.init(nibName: cellClass.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        }

        public func register(_ supplementaryViewClass: UICollectionReusableView.Type, ofKind kind: String) {
            self.register(supplementaryViewClass.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: supplementaryViewClass.reuseIdentifier)
        }

        public func dequeue<T>(_ cellClass: T.Type, for indexPath: IndexPath) -> T where T: Identifiable, T: UICollectionViewCell {
            return self.dequeueReusableCell(withReuseIdentifier: cellClass.reuseIdentifier, for: indexPath) as! T
        }

        public func dequeue<T>(_ supplementaryViewClass: T.Type, ofKind kind: String, for indexPath: IndexPath) -> T? where T: Identifiable, T: UICollectionReusableView {
            return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: supplementaryViewClass.reuseIdentifier, for: indexPath) as? T
        }
    }
#endif
