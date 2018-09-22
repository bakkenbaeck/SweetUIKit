import UIKit

public extension UIViewController {

    /**
     Returns the main application window.
     */
    public func applicationWindow() -> UIWindow {
        return UIApplication.shared.keyWindow!
    }

    /// Adds the controller to the view hierarchy safely.
    ///
    /// - Parameters:
    ///   - controller: The controller to be added
    ///   - frame: The frame for the added controller, if the frame is not provided or is `nil` then the parent controller's frame will be used
    public func addChild(_ controller: UIViewController, frame: CGRect? = nil) {
        addChild(controller)

        if let frame = frame {
            controller.view.frame = frame
        }

        view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }

    /// Removes the controller from the view hierarchy safely.
    ///
    /// - Parameter controller: The controller to be removed
    public func removeChild(_ controller: UIViewController) {
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    }
}
