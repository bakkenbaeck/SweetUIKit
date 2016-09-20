#if os(iOS) || os(tvOS)
import UIKit

public extension UIToolbar {

    public func attachToTop() {
        guard let superview = self.superview else { return }

        self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
    }
}

#endif
