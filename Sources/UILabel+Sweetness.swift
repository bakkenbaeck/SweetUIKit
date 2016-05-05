#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit

public extension UILabel {
    /**
     Calculates the width of the text.
     - returns: The width of the text.
     */
    public func width() -> CGFloat {
        let attributes = [NSFontAttributeName : self.font]
        let rect = (self.text ?? "" as NSString).boundingRectWithSize(CGSize(width: CGFloat.max, height: CGFloat.max), options: .UsesLineFragmentOrigin, attributes: attributes, context: nil)

        return rect.width
    }
}
#endif