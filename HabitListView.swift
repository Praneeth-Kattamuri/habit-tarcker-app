import SwiftUI

struct HabitListView: View {
    @Binding var habits: [Habit]
    @Binding var newHabit: String
    @Binding var selectedReminderTime: Date
    
    var body: some View {
        NavigationView {
            VStack {
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
                
                HabitEntryView(newHabit: $newHabit, selectedReminderTime: $selectedReminderTime)
                    .padding()
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                EditButton()
            }
        }
    }
    
    private func toggleCompletion(for habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index].isCompleted.toggle()
            habits[index].lastUpdated = Date()
            NotificationManager.scheduleReminder(for: habits[index])
        }
    }
    
    private func deleteHabit(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }
}
