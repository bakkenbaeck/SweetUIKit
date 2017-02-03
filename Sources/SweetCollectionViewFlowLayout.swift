#if os(iOS) || os(tvOS)
import UIKit

open class SweetCollectionViewFlowLayout: UICollectionViewFlowLayout {
    public var maximumInteritemSpacing = CGFloat(0.0)

    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let layoutAttributesArray = super.layoutAttributesForElements(in: rect) {
            let cellLayoutAttributes = layoutAttributesArray.filter{$0.representedElementCategory == .cell}

            for (previous, current) in cellLayoutAttributes.enumerateWithPrevious() {
                if let origin = previous?.frame.maxX {
                    if origin + self.maximumInteritemSpacing + current.frame.width <= self.collectionViewContentSize.width {
                        var frame = current.frame
                        frame.origin.x = origin + self.maximumInteritemSpacing
                        current.frame = frame
                    }
                }
            }

            return layoutAttributesArray
        }

        return nil
    }
}

extension Array {
    func enumerateWithPrevious() -> [(Element?, Element)] {
        var array = [(Element?, Element)]()

        for (index, item) in self.enumerated() {
            var previousItem: Element? = nil
            let previousIndex = index - 1

            if previousIndex >= 0 && previousIndex < index {
                previousItem = self[previousIndex]
            }

            array.append((previousItem, item))
        }

        return array
    }
}
#endif
