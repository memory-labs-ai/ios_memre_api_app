
import SwiftUI
import Charts

struct LearningStatsChart: View {
    
    @State private var learningStats: [String: Double] = [:]
    @State private var showingAlert = false
    @State private var alertMessage : String = ""
    @State private var xMax : Int = 24
    
    var body: some View {
        Chart {
            ForEach(learningStats.sorted(by: { (Int($0.key) ?? 0) < (Int($1.key) ?? 0) }), id: \.key) { key, value in
                LineMark(
                    x: .value("Hour", Int(key) ?? 0),
                    y: .value("Efficiency", value)
                )
            }
        }
        .frame(height: 300)
        .chartXScale(domain: 0...xMax)
        .chartYScale(domain: 0...1)
        .chartXAxisLabel(position: .bottom, alignment: .center) {
            Text("Hours")
                .font(.system(size: 16))
                .foregroundColor(.black)
        }
        .chartYAxisLabel(position: .trailing, alignment: .center) {
            Text("Predicted Effeciency")
                .font(.system(size: 16))
                .foregroundColor(.black)
        }
        .padding()
        .onAppear() {
            reloadLearningStats()
        }
    }
    
    private func reloadLearningStats() {
        MemreLearningEngine.getLearningStats { learningStats in
            self.learningStats = learningStats
        } onError: { errorMessage in
            alertMessage = errorMessage
            showingAlert = true
        }
    }
}

struct LearningStatsChart_Previews: PreviewProvider {
    
    static var previews: some View {
        LearningStatsChart()
    }
}
