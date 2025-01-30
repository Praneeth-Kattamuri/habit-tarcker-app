import SwiftUI

struct ContentView: View {
    @StateObject var habitStore = HabitStore()
    
    var body: some View {
        TabView {
            HabitListView(habitStore: habitStore)
                .tabItem {
                    Label("Habits", systemImage: "list.bullet")
                }
            
            StatisticsView(habitStore: habitStore)
                .tabItem {
                    Label("Statistics", systemImage: "chart.bar.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}
