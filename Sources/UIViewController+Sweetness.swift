import UIKit

public extension UIViewController {
    /**
     Returns the main application window.
     */
    public func applicationWindow() -> UIWindow {
        return UIApplication.sharedApplication().keyWindow!
    }
}