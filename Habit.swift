import Foundation

struct Habit: Identifiable, Codable {
    let id: UUID
    var name: String
    var isCompleted: Bool
    var lastUpdated: Date
    var reminderTime: Date // Add reminderTime to store the reminder time
    
    init(name: String, reminderTime: Date = Date()) {
        self.id = UUID()
        self.name = name
        self.isCompleted = false
        self.lastUpdated = Date()
        self.reminderTime = reminderTime
    }
}
