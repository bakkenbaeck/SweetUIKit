#if os(iOS) || os(tvOS)
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
    
    /**
     Calculates the height of the text.
     - parameter width: The width of the Label.
     - returns: The height of the text
     */
    public func height(forWidth width: CGFloat) -> CGFloat {
        let size = self.sizeThatFits(CGSize(width: width, height: CGFloat.max))
        
        return size.height
    }
    
    /**
     Sets the attributedString with line spacing.
     - parameter text: The text.
     - parameter lineSpacing: The line spacing (as used in Sketch).
     */
    public func setSpacedOutText(text: String, lineSpacing: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing - self.font.pointSize
        paragraphStyle.alignment = self.textAlignment
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
}
#endif