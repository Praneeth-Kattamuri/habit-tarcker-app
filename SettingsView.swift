import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Settings")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            List {
                Text("Notification Preferences")
                Text("Account Settings")
                Text("Privacy Policy")
            }
            
            Spacer()
        }
        .navigationTitle("Settings")
    }
}
