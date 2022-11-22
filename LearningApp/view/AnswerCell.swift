
import SwiftUI

struct AnswerCell: View {
    
    var answer : String
    @State private var isSelected = false
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
        }) {
            HStack {
                Text(answer)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
            }
        }
    }
}

struct AnswerCell_Previews: PreviewProvider {
    
    static var previews: some View {
        AnswerCell(answer: "Test")
    }
}
