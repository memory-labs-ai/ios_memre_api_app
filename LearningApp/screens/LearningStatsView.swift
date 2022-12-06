
import SwiftUI

struct LearningStatsView: View {
    
    @State private var showingAlert = false
    @State private var alertMessage : String = ""
    
    var body: some View {
        VStack {
            Spacer()
            LearningStatsChart()
                .padding(.leading, 20)
                .padding(.trailing, 20)
            Spacer()
        }.navigationTitle("Learning Stats")
            .background(Color.lightGrey)
    }
}

struct LearningStatsView_Previews: PreviewProvider {
    
    static var previews: some View {
        LearningStatsView()
    }
}
