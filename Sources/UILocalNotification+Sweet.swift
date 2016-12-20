#if os(iOS)
    import UIKit

    public extension UILocalNotification {
        static let idKey = "idKey"
        static let fireDateKey = "fireDateKey"

        /// Schedules a local notification.
        ///
        /// - Parameters:
        ///   - notificationName: The name used to represent a local notification in your app.
        ///   - fireDate: The date when the notification will trigger
        ///   - soundName: The name of the sound to be used when the notification is received.
        ///   - message: The message that the app will use for your local notification.
        ///   - actionTitle: The title of the action to be displayed by your notification, it's optional, though, since Apple provides a good default for this.
        public static func schedule(named notificationName: String, fireDate: Date, soundName: String? = nil, message: String, actionTitle: String? = nil) {
            let notification = UILocalNotification()
            notification.soundName = soundName

            notification.fireDate = fireDate
            notification.timeZone = TimeZone.current
            notification.alertBody = message
            notification.alertAction = actionTitle
            notification.hasAction = actionTitle != nil

            var userInfo = [AnyHashable: Any]()
            userInfo[idKey] = notificationName
            userInfo[fireDateKey] = fireDate
            notification.userInfo = userInfo

            UIApplication.shared.scheduleLocalNotification(notification)
        }

        /// Finds a local notification for certain id.
        ///
        /// - Parameter notificationName: The name user to store the notification.
        /// - Returns: A local notification that matches the provided id.
        public static func find(named notificationName: String) -> UILocalNotification? {
            let notifications = UIApplication.shared.scheduledLocalNotifications ?? [UILocalNotification]()
            let filteredNotifications = notifications.filter { notification in
                let filteredNotificationID = notification.userInfo?[idKey] as? String
                return filteredNotificationID == notificationName
            }

            return filteredNotifications.first
        }

        /// Cancels a local notification.
        ///
        /// - Parameter notificationName: The name user to store the notification.
        public static func cancel(named notificationName: String) {
            if let notification = self.find(named: notificationName) {
                UIApplication.shared.cancelLocalNotification(notification)
            }
        }

        /// Cancels all the local notifications for the current app.
        public static func cancelAll() {
            let notifications = UIApplication.shared.scheduledLocalNotifications ?? [UILocalNotification]()
            notifications.forEach { notification in
                UIApplication.shared.cancelLocalNotification(notification)
            }
        }
    }
#endif
