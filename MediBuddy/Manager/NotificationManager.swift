//
//  NotificationManager.swift
//  medi buddy test
//
//  Created by Sachin Gunawardena on 2025-04-23.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    private init() {}

    func requestPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("🔴 Notification permission error: \(error)")
            } else {
                print("✅ Notification permission granted: \(granted)")
            }
        }
    }

    /// Schedule notification at exact date + time
    func scheduleNotification(title: String, body: String, at date: Date, repeats: Bool = false) {
        let content = UNMutableNotificationContent()
        content.title = "Medi Buddy"
        content.body = "Remeinder to take your medicine on time"
        content.sound = .default

        let triggerDate = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: date
        )

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: repeats)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("🔴 Scheduling failed: \(error.localizedDescription)")
            } else {
                print("✅ Notification scheduled at: \(date)")
            }
        }
    }
}
