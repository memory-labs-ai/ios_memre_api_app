
import Foundation

class LearningStat: NSObject {
    var hoursFromNow: Int
    var efficiency: Double
    
    init(hoursFromNow: Int,
         efficiency: Double) {
        self.hoursFromNow = hoursFromNow
        self.efficiency = efficiency
    }
}
