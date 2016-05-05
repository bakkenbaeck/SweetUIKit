import UIKit

extension UIViewController {
    /**
     Returns the main application window.
     */
    func applicationWindow() -> UIWindow {
        return UIApplication.sharedApplication().keyWindow!
    }
}