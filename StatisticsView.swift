import SwiftUI

struct StatisticsView: View {
    @ObservedObject var habitStore: HabitStore
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Habit Progress")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                
                List {
                    ForEach(habitStore.habits) { habit in
                        VStack(alignment: .leading) {
                            Text(habit.name)
                                .font(.headline)
                            
                            // Progress Bar for Each Habit
                            ProgressView(value: habit.isCompleted ? 1.0 : 0.0)
                                .progressViewStyle(LinearProgressViewStyle())
                                .frame(height: 8)
                                .accentColor(habit.isCompleted ? .green : .gray)
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .navigationTitle("Statistics")
        }
    }
}
