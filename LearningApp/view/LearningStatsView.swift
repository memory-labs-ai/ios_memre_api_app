
import SwiftUI

struct LearningStatsView: View {
    
    @State private var showingAlert = false
    @State private var alertMessage : String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                LearningStatsChart()
                Spacer()
            }.navigationTitle("Learning Stats")
        }
    }
}

struct LearningStatsView_Previews: PreviewProvider {
    
    static var previews: some View {
        LearningStatsView()
    }
}
