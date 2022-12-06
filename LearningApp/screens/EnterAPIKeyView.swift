
import SwiftUI

struct EnterAPIKeyView: View {
    
    @State private var apiKeyTextEntry : String = ""
    @State private var showingAlert = false
    @State private var alertMessage : String = ""
    @State private var isShowingStudyItemsView = false
    @State private var runOnceFlag = false
    
    var body: some View {
        VStack {
            Image("HomeIcon")
                .resizable(resizingMode: .stretch)
                .frame(width: 100, height: 100)
            Spacer()
            TextField(LocalizedStringKey("Enter your RapidAPI key"),
                      text: $apiKeyTextEntry).textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
            NavigationLink(destination: StudyItemsView(),
                           isActive: $isShowingStudyItemsView) {
                EmptyView()
            }
            VStack {
                Button("Create new user") {
                    MemreLearningEngine.createUser(apiKeyTextEntry,
                                                   onCompletion: onCreateUserCompletion,
                                                   onError: onCreateUserError)
                }.font(.system(size: 20))
                    .padding()
                    .background(Color.primaryRed)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Oops"),
                          message: Text(alertMessage),
                          dismissButton: .cancel(Text("OK")))
                }
                if (MyUserDefaults.hasPreviousApiKeyAndUser()) {
                    Button("Use last user") {
                        isShowingStudyItemsView = true
                    }.font(.system(size: 20))
                        .padding()
                        .background(Color.primaryRed)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
            }
            Spacer()
            Link (destination: URL(string: "https://rapidapi.com/memre-memre-default/api/learning-engine/")!) {
                   Text("View the api docs")
                       .font(.system(size: 15))
                       .foregroundColor(.black)
                       .underline()
                 }
        }
        .padding()
        .navigationBarTitle("Memre Learning Engine", displayMode: .inline).foregroundColor(Color.primaryRed)
        .background(Color.lightGrey)
        .onAppear {
            isShowingStudyItemsView = false
            if let currentKey = MyUserDefaults.getApiKey() {
                apiKeyTextEntry = currentKey
            }
            if (!runOnceFlag) {
                runOnceFlag = true
                if let _ = MyUserDefaults.getUserId() {
                    isShowingStudyItemsView = true
                }
            }
        }
    }
    
    private func onCreateUserCompletion() {
        isShowingStudyItemsView = true
    }
    
    private func onCreateUserError(errorMessage: String) {
        alertMessage = errorMessage
        showingAlert = true
    }
}

struct EnterAPIKeyView_Previews: PreviewProvider {
    
    static var previews: some View {
        EnterAPIKeyView()
    }
}
