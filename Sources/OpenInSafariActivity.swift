import UIKit

class OpenInSafariActivity: UIActivity {
    fileprivate var url: URL?

    override var activityType: UIActivityType? {
        return UIActivityType(String(describing: self.classForCoder))
    }

    override var activityTitle: String? {
        let defaultTitle = Bundle(for: self.classForCoder).localizedString(forKey: "Open in Safari", value: "Open in Safari Default", table: "OpenInSafariActivity")
        let title = Bundle.main.localizedString(forKey: "Open in Safari", value: defaultTitle, table: nil)

        return title
    }

    override var activityImage: UIImage? {
        return UIImage(named: "Safari", in: Bundle(for: self.classForCoder), compatibleWith: nil)
    }

    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        for item in activityItems {
            if let item = item as? URL {
                return UIApplication.shared.canOpenURL(item)
            }
        }

        return false
    }

    override func prepare(withActivityItems activityItems: [Any]) {
        for item in activityItems {
            if let item = item as? URL {
                self.url = item
                break
            }
        }
    }

    override func perform() {
        if let url = self.url {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:]) { completed in
                    self.activityDidFinish(completed)
                }
            } else {
                let completed = UIApplication.shared.openURL(url)
                self.activityDidFinish(completed)
            }
        } else {
            self.activityDidFinish(false)
        }
    }
}
