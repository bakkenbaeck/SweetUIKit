#if os(iOS) || os(tvOS)
    import UIKit

    public extension IndexPath {

        public enum Direction {
            case same
            case before
            case ahead
        }

        fileprivate func comparePosition(_ ownRow: Int, otherRow: Int) -> Direction {
            if ownRow == otherRow {
                return .same
            } else if ownRow < otherRow {
                return .before
            } else {
                return .ahead
            }
        }

        public func comparePosition(to indexPath: IndexPath) -> Direction {
            if self.section == indexPath.section {
                return self.comparePosition(self.row, otherRow: indexPath.row)
            } else if self.section < indexPath.section {
                return .before
            } else {
                return .ahead
            }
        }

        public func next(collectionView: UICollectionView) -> IndexPath? {
            var found = false
            let indexPaths = collectionView.indexPaths
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
            let indexPaths = collectionView.indexPaths
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
            for section in 0 ..< sections {
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
            for section in 0 ..< sections {
                if section < self.section {
                    let rows = collectionView.numberOfItems(inSection: section)
                    count += rows
                }
            }

            return count + self.row
        }
    }
#endif
