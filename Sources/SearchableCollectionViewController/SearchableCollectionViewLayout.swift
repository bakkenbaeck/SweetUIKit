import Foundation
import UIKit

open class SearchableCollectionViewLayout: UICollectionViewFlowLayout {

    private var searchBackgroundColor = SearchBarView.defaultSearchBackgroundColor

    override init() {
        super.init()

        self.register(SearchBarView.self, forDecorationViewOfKind: SearchBarView.kind)
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = super.layoutAttributesForElements(in: rect)?.flatMap { layoutAttribute in
            return layoutAttribute.copy() as? UICollectionViewLayoutAttributes
        }

        attributes?.forEach { attribute in
            if attribute.representedElementCategory != .decorationView {
                let center = attribute.center
                attribute.center = CGPoint(x: center.x, y: center.y + SearchBarView.height)
            }
        }

        let decorationViewAttributes = self.layoutAttributesForDecorationView(ofKind: SearchBarView.kind, at: IndexPath(item: 0, section: 0))!
        attributes?.append(decorationViewAttributes)

        return attributes
    }

    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath).flatMap { layoutAttribute in
            layoutAttribute.copy() as? UICollectionViewLayoutAttributes
        }

        if let center = attributes?.center as CGPoint? {
            attributes?.center = CGPoint(x: center.x, y: center.y + SearchBarView.height)
        }

        return attributes
    }

    open override func layoutAttributesForDecorationView(ofKind _: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: SearchBarView.kind, with: indexPath)
        attributes.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: SearchBarView.height)

        return attributes
    }
}
