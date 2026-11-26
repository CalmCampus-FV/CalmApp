import Foundation
import UserNotifications

/// Optional weekly reminder, scheduled locally with UNUserNotificationCenter.
/// There is no push server and nothing is sent off the phone.
enum ReminderScheduler {
    static let identifier = "calmcampus.weekly-reminder"
    /// Sunday (1 in the Gregorian calendar) at 18:00.
    static let weekday = 1
    static let hour = 18

    static func trigger() -> UNCalendarNotificationTrigger {
        var parts = DateComponents()
        parts.weekday = weekday
        parts.hour = hour
        parts.minute = 0
        return UNCalendarNotificationTrigger(dateMatching: parts, repeats: true)
    }

    /// Asks for permission if needed and schedules the reminder. Returns false if not allowed.
    static func enable(language: AppLanguage,
                       center: UNUserNotificationCenter = .current()) async -> Bool {
        let granted = (try? await center.requestAuthorization(options: [.alert, .sound])) ?? false
        guard granted else { return false }
        await schedule(language: language, center: center)
        return true
    }

    static func schedule(language: AppLanguage, center: UNUserNotificationCenter = .current()) async {
        let content = UNMutableNotificationContent()
        content.title = S.notificationTitle.text(language)
        content.body = S.notificationBody.text(language)
        content.sound = .default
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
        try? await center.add(UNNotificationRequest(identifier: identifier, content: content, trigger: trigger()))
    }

    static func disable(center: UNUserNotificationCenter = .current()) {
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
        center.removeDeliveredNotifications(withIdentifiers: [identifier])
    }

    static func isAuthorized(center: UNUserNotificationCenter = .current()) async -> Bool {
        let status = await center.notificationSettings().authorizationStatus
        return status == .authorized || status == .provisional
    }
}
