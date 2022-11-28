
import SwiftUI

struct ChartGroupBoxStyle : GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .padding(.leading, 20)
            .padding(.top, 20)
            .background(Color.white)
            .cornerRadius(20)
    }
}
