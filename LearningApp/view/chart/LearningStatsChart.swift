
import SwiftUI
import Charts

struct LearningStatsChart: View {
    
    @State private var learningStats: [LearningStat] = []
    @State private var showingAlert = false
    @State private var alertMessage : String = ""
    @State private var xMax : Int = 24
    
    var body: some View {
        GroupBox {
            Chart {
                ForEach(learningStats.sorted(by: { $0.hoursFromNow < $1.hoursFromNow }), id: \.hoursFromNow) { learningStat in
                    LineMark(
                        x: .value("Hour", learningStat.hoursFromNow),
                        y: .value("Efficiency", learningStat.effeciency)
                    )
                }
            }
            .frame(height: 300)
            .chartXScale(domain: 0...xMax)
            .chartYScale(domain: 0...1)
            .chartXAxisLabel(position: .bottom, alignment: .center) {
                Text("Hour")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
            }
            .chartYAxisLabel(position: .trailing, alignment: .center) {
                Text("Predicted Effeciency")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
            }
            .chartBackground { chartProxy in
                Color.white
            }
            .padding()
            .onAppear() {
                reloadLearningStats()
            }
        }.groupBoxStyle(ChartGroupBoxStyle())
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
