import SwiftUI

struct ProfileView: View {
    let userProfile = UserProfile(name: "John Doe", email: "johndoe@example.com", age: 30, bio: "Software Developer and Habit Tracker Enthusiast.")
    
    var body: some View {
        VStack {
            Text(userProfile.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10)
            
            Text(userProfile.email)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Age: \(userProfile.age)")
                .font(.subheadline)
                .padding(.top, 5)
            
            Text(userProfile.bio)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
                .padding(.horizontal, 20)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
    }
}

struct UserProfile {
    var name: String
    var email: String
    var age: Int
    var bio: String
}
