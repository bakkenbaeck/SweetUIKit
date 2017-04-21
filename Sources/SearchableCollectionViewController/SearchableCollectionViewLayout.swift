import Foundation
import UIKit

class SearchableCollectionViewLayout: UICollectionViewFlowLayout {
    
    private var searchBackgroundColor = SearchBarView.defaultSearchBackgroundColor
    
    override init() {
        super.init()
        
        register(SearchBarView.self, forDecorationViewOfKind: SearchBarView.kind)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = super.layoutAttributesForElements(in: rect)?.flatMap({ $0.copy() as? UICollectionViewLayoutAttributes })
        
        attributes?.forEach{ attribute in
            if attribute.representedElementCategory != .decorationView {
                let center = attribute.center
                attribute.center = CGPoint(x: center.x, y: center.y + SearchBarView.height)
            }
        }
        
        let decorationViewAttributes = self.layoutAttributesForDecorationView(ofKind: SearchBarView.kind, at: IndexPath(item: 0, section: 0))!
        attributes?.append(decorationViewAttributes)
        return attributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath).flatMap({ $0.copy() as? UICollectionViewLayoutAttributes })
        if let center = attributes?.center as CGPoint? {
            attributes?.center = CGPoint(x: center.x, y: center.y + SearchBarView.height)
        }
        
        return attributes
    }
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: String(describing: SearchBarView.self),
                                                          with: indexPath)
        attributes.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: SearchBarView.height)
        
        return attributes
    }
}
