
import SwiftUI

struct AnswerCell: View {
    
    var answer : String
    var isSelected = false
    var onPressed : (String) -> ()
    
    var body: some View {
        Button(action: {
            onPressed(answer)
        }) {
            HStack {
                Text(answer)
                    .font(.system(size: 16))
                    .foregroundColor(isSelected ? .white : .black)
            }
        }
        .frame(minWidth: 300,
               idealWidth: .infinity,
               maxWidth: .infinity,
               alignment: .leading)
        .padding()
        .background(isSelected ? .blue : .clear)
        .cornerRadius(5)
    }
}

struct AnswerCell_Previews: PreviewProvider {
    
    static var previews: some View {
        AnswerCell(answer: "Test",
                   isSelected: true) { answer in
            //
        }
    }
}
