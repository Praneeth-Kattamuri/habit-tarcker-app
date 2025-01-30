import Foundation

class HabitStore: ObservableObject {
    @Published var habits: [Habit] {
        didSet {
            HabitStore.saveHabits(habits)
        }
    }
    
    init() {
        // Clear old data from UserDefaults
        HabitStore.clearHabitsData()
        
        // Load fresh habits (will be empty since the data was cleared)
        self.habits = HabitStore.loadHabits()
    }
    
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
    
    func addHabit(_ habit: Habit) {
        habits.append(habit)
    }
    
    func toggleCompletion(for habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index].isCompleted.toggle()
            habits[index].lastUpdated = Date()
            NotificationManager.scheduleReminder(for: habits[index])
        }
    }
    
    func deleteHabit(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }
    
    // Method to clear habits data from UserDefaults
    static func clearHabitsData() {
        UserDefaults.standard.removeObject(forKey: "habits")
    }
}
