
import Foundation

class LearningStat: NSObject {
    var hoursFromNow: Int
    var effeciency: Double
    
    init(hoursFromNow: Int,
         effeciency: Double) {
        self.hoursFromNow = hoursFromNow
        self.effeciency = effeciency
    }
}
