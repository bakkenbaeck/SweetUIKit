import UIKit

extension UIAlertController {
    static func dismissableAlert(title title: String, message: String? = nil) -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        controller.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: .Default, handler: nil))

        return controller
    }

    static func destructiveConfirmationAlert(title title: String? = nil, message: String, destructiveActionTitle: String? = nil, destructiveBlock: (Void -> Void)? = nil) -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        controller.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .Cancel, handler: nil))

        if let destructiveBlock = destructiveBlock {
            controller.addAction(UIAlertAction(title: destructiveActionTitle ?? NSLocalizedString("Delete", comment: ""), style: .Destructive, handler: { _ in
                destructiveBlock()
            }))
        }

        return controller
    }

    static func errorAlert(error: NSError) -> UIAlertController {
        let controller = UIAlertController(title: NSLocalizedString("Oops, something went wrong", comment: ""), message: error.localizedDescription, preferredStyle: .Alert)
        controller.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: .Default, handler: nil))

        return controller
    }

    static func progressAlert(title: String) -> UIAlertController {
        let controller = UIAlertController(title: title + "\n\n", message: nil, preferredStyle: .Alert)
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .White)
        indicator.color = UIColor.grayColor()
        indicator.center = CGPoint(x: 135, y: 65.5)
        indicator.startAnimating()
        controller.view.addSubview(indicator)

        return controller
    }
}
