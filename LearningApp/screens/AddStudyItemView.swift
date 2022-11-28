
import SwiftUI

struct AddStudyItemView: View {
    
    var onCompletion : () -> ()
    @Environment(\.dismiss) private var dismiss
    
    @State private var question : String = ""
    @State private var answer : String = ""
    @State private var distractors : String = ""
    @State private var showingAlert = false
    @State private var alertMessage : String = ""
    @State private var loading = false
    
    var body: some View {
        VStack {
            Spacer()
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
                    dismiss()
                }.font(.system(size: 20))
                    .padding()
                    .background(Color.memreRed)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                Button("Create Study Item") {
                    createNewStudyItem()
                }.font(.system(size: 20))
                    .padding()
                    .background(Color.memreRed)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Oops"),
                          message: Text(alertMessage),
                          dismissButton: .cancel(Text("OK")))
                }
            }
            Spacer()
        }
        .overlay {
            if loading {
                ZStack {
                    Color(white: 0, opacity: 0.75).ignoresSafeArea()
                    ProgressView().tint(.white)
                }
            }
        }
        .navigationTitle("Add Study Item")
        .background(Color.memreLightGrey)
    }
    
    private func parseDistractors() -> [String] {
        return distractors.components(separatedBy: ",")
    }
    
    private func createNewStudyItem() {
        loading = true
        MemreLearningEngine.createLearningItem(onCompletion: { learningItemId in
            loading = false
            MyUserDefaults.addStudyItem(StudyItem(id: UUID().uuidString,
                                                 learningEngineId: learningItemId,
                                                 question: question,
                                                 answer: answer,
                                                  distractors: parseDistractors()))
            onCompletion()
            DispatchQueue.main.async {
                dismiss()
            }
        },
                                            onError: { errorMessage in
            loading = false
            alertMessage = errorMessage
            showingAlert = true
        })
    }
}

struct AddStudyItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddStudyItemView {}
    }
}
