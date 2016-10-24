#if os(iOS) || os(tvOS)
import UIKit

public extension UIViewController {
    /**
     Returns the main application window.
     */
    public func applicationWindow() -> UIWindow {
        if  UIApplication.responds(to: NSSelectorFromString("shared")) {
            return (UIApplication.value(forKey: "shared.") as! UIApplication).keyWindow!
        } else {
            fatalError("This can't be called from inside an app extension.")
        }
    }
}
#endif
