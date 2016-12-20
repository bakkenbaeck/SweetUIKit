import UIKit

public extension UILocalNotification {
    static let idKey = "idKey"
    static let fireDateKey = "fireDateKey"

    public static func create(_ id: String, fireDate: Date, soundName: String? = nil, message: String, actionTitle: String? = nil) {
        let notification = UILocalNotification()
        notification.soundName = soundName

        notification.fireDate = fireDate
        notification.timeZone = TimeZone.current
        notification.alertBody = message
        notification.alertAction = actionTitle
        notification.hasAction = actionTitle != nil

        var userInfo = [AnyHashable: Any]()
        userInfo[idKey] = id
        userInfo[fireDateKey] = Date()
        notification.userInfo = userInfo

        UIApplication.shared.scheduleLocalNotification(notification)
    }

    public static func find(_ id: String) -> UILocalNotification? {
        let notifications = UIApplication.shared.scheduledLocalNotifications ?? [UILocalNotification]()
        let filteredNotifications = notifications.filter { notification in
            let filteredNotificationID = notification.userInfo?[idKey] as? String
            return filteredNotificationID == id
        }

        return filteredNotifications.first
    }

    public static func delete(_ id: String) {
        if let notification = find(id) {
            UIApplication.shared.cancelLocalNotification(notification)
        }
    }
}
