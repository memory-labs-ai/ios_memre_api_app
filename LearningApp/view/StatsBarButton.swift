
import SwiftUI

struct StatsBarButton: View {
    
    @State private var showLearningStatsView = false
    
    var body: some View {
        NavigationLink(destination: LearningStatsView(),
                       isActive: $showLearningStatsView) {
            Button(action: {
                showLearningStatsView = true
            }) {
                Text("Stats")
                    .font(.system(size: 18))
                    .foregroundColor(.memreRed)
            }
        }
    }
}

struct StatsBarButton_Previews: PreviewProvider {
    
    static var previews: some View {
        StatsBarButton()
    }
}
