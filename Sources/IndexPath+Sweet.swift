#if os(iOS) || os(tvOS)
import UIKit

public extension IndexPath {
    public func indexPaths(collectionView: UICollectionView) -> [IndexPath] {
        var indexPaths = [IndexPath]()

        let sections = collectionView.numberOfSections
        for section in 0..<sections {
            let rows = collectionView.numberOfItems(inSection: section)
            for row in 0..<rows {
                indexPaths.append(IndexPath(row: row, section: section))
            }
        }

        return indexPaths
    }

    public func next(collectionView: UICollectionView) -> IndexPath? {
        var found = false
        let indexPaths = self.indexPaths(collectionView: collectionView)
        for indexPath in indexPaths {
            if found == true {
                return indexPath
            }

            if indexPath == self {
                found = true
            }
        }

        return nil
    }

    public func previous(collectionView: UICollectionView) -> IndexPath? {
        var previousIndexPath: IndexPath?
        let indexPaths = self.indexPaths(collectionView: collectionView)
        for indexPath in indexPaths {
            if indexPath == self {
                return previousIndexPath
            }

            previousIndexPath = indexPath
        }

        return nil
    }

    public static func firstIndexPathForIndex(collectionView: UICollectionView, index: Int) -> IndexPath? {
        var count = 0
        let sections = collectionView.numberOfSections
        for section in 0..<sections {
            let rows = collectionView.numberOfItems(inSection: section)
            if index >= count && index < count + rows {
                let foundRow = index - count
                return IndexPath(row: foundRow, section: section)
            }
            count += rows
        }

        return nil
    }

    public func totalRowCount(collectionView: UICollectionView) -> Int {
        var count = 0
        let sections = collectionView.numberOfSections
        for section in 0..<sections {
            if section < self.section {
                let rows = collectionView.numberOfItems(inSection: section)
                count += rows
            }
        }
        
        return count + self.row
    }
}
#endif
