import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var reminderTime: Date
    var isCompleted: Bool = false
    var lastUpdated: Date = Date()
}
