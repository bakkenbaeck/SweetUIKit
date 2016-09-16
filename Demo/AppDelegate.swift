import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let layout = UICollectionViewFlowLayout()
        let navigationController = UINavigationController(rootViewController: CollectionController(collectionViewLayout: layout))
        let window = UIWindow()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

