#if os(iOS) || os(tvOS)
import UIKit

public extension UIView {
    /**
     Shakes the view. Useful for displaying failures to users.
     */
    public func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(self.center.x - 10.0, self.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(self.center.x + 10.0, self.center.y))
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.layer.addAnimation(animation, forKey: "position")
    }
}

public extension UIView {
    public convenience init(withAutoLayout autoLayout: Bool) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = !autoLayout
    }
}

#endif
