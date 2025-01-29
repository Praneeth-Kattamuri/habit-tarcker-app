import UserNotifications

class NotificationManager {
    static func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
    }
    
    static func scheduleReminder(for habit: Habit) {
        let content = UNMutableNotificationContent()
        content.title = "Habit Reminder"
        content.body = "Don't forget to complete your habit: \(habit.name)"
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: habit.reminderTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: habit.id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling reminder: \(error.localizedDescription)")
            } else {
                print("Reminder scheduled successfully for \(habit.name)")
            }
        }
    }
}
