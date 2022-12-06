
import SwiftUI

struct StudyItemCell: View {
    
    var studyItem : StudyItem
    var isRecommended: Bool
    @State private var showStudyQuizView = false
    
    var body: some View {
        NavigationLink(destination: StudyQuizView(studyItem: studyItem),
                       isActive: $showStudyQuizView) {
            Button(action: {
                showStudyQuizView = true
            }) {
                HStack {
                    Text(studyItem.question)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    if (isRecommended) {
                        Spacer()
                        Image(systemName: "star.square.fill")
                            .scaledToFill()
                            .foregroundColor(.orange)
                            .frame(width: 20, height: 20)
                    }
                }
            }
        }
    }
}

struct StudyItemCell_Previews: PreviewProvider {
    
    static var previews: some View {
        StudyItemCell(studyItem: StudyItem.previewStudyItem(),
                      isRecommended: true)
    }
}
