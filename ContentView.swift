import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var habits: [Habit] = [] {
        didSet {
            saveHabits()
        }
    }
    @State private var newHabit: String = ""
    @State private var selectedReminderTime: Date = Date() // Default reminder time
    
    var body: some View {
        NavigationView {
            VStack {
                // Habit List
                List {
                    ForEach(habits) { habit in
                        HStack {
                            Text(habit.name)
                                .font(.body)
                            Spacer()
                            Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(habit.isCompleted ? .green : .gray)
                                .onTapGesture {
                                    toggleCompletion(for: habit)
                                }
                        }
                    }
                    .onDelete(perform: deleteHabit)
                }
                
                // Habit Entry & Reminder Time Section
                VStack {
                    TextField("Enter new habit", text: $newHabit)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    // Date picker for setting reminder time
                    DatePicker("Set Reminder Time", selection: $selectedReminderTime, displayedComponents: .hourAndMinute)
                        .padding()
                        .labelsHidden()
                        .datePickerStyle(CompactDatePickerStyle()) // Simplified date picker style
                }
                .padding()
                
                // Add Habit Button
                Button(action: addHabit) {
                    Text("Add Habit")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                EditButton()
            }
        }
        .onAppear {
            requestNotificationPermission() // Request notification permission
            loadHabits()
        }
    }
    
    private func addHabit() {
        guard !newHabit.isEmpty else { return }
        let newHabitObject = Habit(name: newHabit, reminderTime: selectedReminderTime) // Include selected reminder time
        habits.append(newHabitObject)
        scheduleReminder(for: newHabitObject) // Schedule reminder when new habit is added
        newHabit = "" // Reset the text field after adding habit
    }
    
    private func toggleCompletion(for habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index].isCompleted.toggle()
            habits[index].lastUpdated = Date()
            scheduleReminder(for: habits[index]) // Reschedule reminder after status update
        }
    }
    
    private func deleteHabit(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }
    
    // Save habits to UserDefaults
    private func saveHabits() {
        if let encoded = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encoded, forKey: "habits")
        }
    }
    
    // Load habits from UserDefaults
    private func loadHabits() {
        if let savedData = UserDefaults.standard.data(forKey: "habits"),
           let decoded = try? JSONDecoder().decode([Habit].self, from: savedData) {
            habits = decoded
        }
    }
    
    // Request notification permission
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
    }
    
    // Convert the date to EST time zone
    private func convertToEST(date: Date) -> Date {
        let estTimeZone = TimeZone(identifier: "America/New_York")!
        let calendar = Calendar.current
        let components = calendar.dateComponents(in: estTimeZone, from: date)
        
        return calendar.date(from: components)!
    }
    
    // Schedule reminder notification
    private func scheduleReminder(for habit: Habit) {
        let content = UNMutableNotificationContent()
        content.title = "Habit Reminder"
        content.body = "Don't forget to complete your habit: \(habit.name)"
        content.sound = .default
        
        // Convert the reminder time to EST
        let estDate = convertToEST(date: habit.reminderTime)
        
        // Create a trigger based on the converted EST reminder time
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: estDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: habit.id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling reminder: \(error.localizedDescription)")
            } else {
                print("Reminder scheduled successfully!")
                print("Notification scheduled for habit: \(habit.name) at \(estDate)")
            }
        }
    }
}
