
import SwiftUI

struct AnswerCell: View {
    
    var answer : String
    var isCorrectAnswer = false
    var isSelected = false
    var didSubmitAnswer = false
    var onPressed : (String) -> ()
    
    var body: some View {
        Button(action: {
            if (!didSubmitAnswer) {
                onPressed(answer)
            }
        }) {
            HStack {
                Text(answer)
                    .font(.system(size: 16))
                    .foregroundColor(getTextColor())
            }
        }
        .frame(minWidth: 300,
               idealWidth: .infinity,
               maxWidth: .infinity,
               alignment: .leading)
        .padding()
        .background(getBackgroundColor())
        .cornerRadius(5)
    }
    
    func getTextColor() -> Color {
        let backgroundColor = getBackgroundColor()
        return backgroundColor == .clear ? .black : .white
    }
    
    func getBackgroundColor() -> Color {
        if (didSubmitAnswer && isSelected && isCorrectAnswer) {
            return .green
        } else if (didSubmitAnswer && isSelected) {
            return .red
        } else if (didSubmitAnswer && isCorrectAnswer) {
            return .green
        } else if (isSelected) {
            return .blue
        } else {
            return .clear
        }
    }
}

struct AnswerCell_Previews: PreviewProvider {
    
    static var previews: some View {
        AnswerCell(answer: "Test",
                   isCorrectAnswer: true,
                   isSelected: true,
                   didSubmitAnswer: true) { answer in
            //
        }
    }
}
