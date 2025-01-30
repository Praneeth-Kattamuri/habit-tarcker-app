import SwiftUI

struct HabitListView: View {
    @ObservedObject var habitStore: HabitStore
    @State private var newHabit = ""
    @State private var selectedReminderTime = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(habitStore.habits) { habit in
                        HStack {
                            Text(habit.name)
                                .font(.body)
                            Spacer()
                            Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(habit.isCompleted ? .green : .gray)
                                .onTapGesture {
                                    habitStore.toggleCompletion(for: habit)
                                }
                        }
                    }
                    .onDelete(perform: habitStore.deleteHabit)
                }
                
                HabitEntryView(habitStore: habitStore, newHabit: $newHabit, selectedReminderTime: $selectedReminderTime)
                    .padding()
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                EditButton()
            }
        }
    }
}
