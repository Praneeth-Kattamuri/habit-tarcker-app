import Foundation

class HabitStore {
    static func loadHabits() -> [Habit] {
        if let savedData = UserDefaults.standard.data(forKey: "habits"),
           let decoded = try? JSONDecoder().decode([Habit].self, from: savedData) {
            return decoded
        }
        return []
    }
    
    static func saveHabits(_ habits: [Habit]) {
        if let encoded = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encoded, forKey: "habits")
        }
    }
    
    static func addHabit(_ habit: Habit) {
        var habits = loadHabits()
        habits.append(habit)
        saveHabits(habits)
    }
}
