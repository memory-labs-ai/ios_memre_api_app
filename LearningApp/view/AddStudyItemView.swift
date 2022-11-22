
import SwiftUI

struct AddStudyItemView: View {
    
    var onCompletion : () -> ()
    var onCancel : () -> ()
    
    @State private var question : String = ""
    @State private var answer : String = ""
    @State private var distractors : String = ""
    @State private var showingAlert = false
    @State private var alertMessage : String = ""
    
    var body: some View {
        VStack {
            TextField(LocalizedStringKey("Question"),
                      text: $question).textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
            TextField(LocalizedStringKey("Answer"),
                      text: $answer).textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
            TextField(LocalizedStringKey("Distractors (comma seperated)"),
                      text: $distractors).textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
            HStack {
                Button("Cancel") {
                    onCancel()
                }.font(.system(size: 20))
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                Button("Create Study Item") {
                    MemreLearningEngine.createLearningItem(onCompletion: { learningItemId in
                        MyUserDefaults.addStudyItem(StudyItem(id: UUID().uuidString,
                                                             learningEngineId: learningItemId,
                                                             question: question,
                                                             answer: answer,
                                                              distractors: parseDistractors()))
                        onCompletion()
                    },
                                                        onError: { errorMessage in
                        alertMessage = errorMessage
                        showingAlert = true
                    })
                }.font(.system(size: 20))
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Oops"),
                          message: Text(alertMessage),
                          dismissButton: .cancel(Text("OK")))
                }
            }
        }
    }
    
    private func parseDistractors() -> [String] {
        return distractors.components(separatedBy: ",")
    }
}

struct AddStudyItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddStudyItemView {} onCancel: {}
    }
}
