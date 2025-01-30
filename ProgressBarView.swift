import SwiftUI

struct ProgressBarView: View {
    var progress: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 10)
                .foregroundColor(Color.gray.opacity(0.3))
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: CGFloat(progress) * 150, height: 10)
                .foregroundColor(.blue)
                .animation(.easeInOut(duration: 0.5), value: progress)
        }
    }
}
