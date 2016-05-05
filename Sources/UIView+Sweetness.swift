import UIKit

extension UIView {
    /**
     Drops the elements in an entity.
     */
    func shake() {
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
