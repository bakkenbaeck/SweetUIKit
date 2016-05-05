import UIKit

extension UILabel {
    /**
     Drops the elements in an entity.
     - returns: The predicate to be used to filter out removed objects (optional).
     */
    func width() -> CGFloat {
        let attributes = [NSFontAttributeName : self.font]
        let rect = (self.text ?? "" as NSString).boundingRectWithSize(CGSize(width: CGFloat.max, height: CGFloat.max), options: .UsesLineFragmentOrigin, attributes: attributes, context: nil)

        return rect.width
    }
}