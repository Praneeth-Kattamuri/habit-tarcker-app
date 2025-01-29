import SwiftUI

struct HabitEntryView: View {
    @Binding var newHabit: String
    @Binding var selectedReminderTime: Date
    
    var body: some View {
        VStack {
            TextField("Enter new habit", text: $newHabit)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            DatePicker("Set Reminder Time", selection: $selectedReminderTime, displayedComponents: .hourAndMinute)
                .padding()
                .labelsHidden()
                .datePickerStyle(CompactDatePickerStyle())
            
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
    }
    
    private func addHabit() {
        guard !newHabit.isEmpty else { return }
        let newHabitObject = Habit(name: newHabit, reminderTime: selectedReminderTime)
        HabitStore.addHabit(newHabitObject)
        NotificationManager.scheduleReminder(for: newHabitObject)
        newHabit = ""
    }
}
