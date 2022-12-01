
import SwiftUI

struct StudyItemsView: View {
    
    @State var studyItems: [StudyItem] = []
    @State private var recommendedStudyItemIds: [String] = []
    @State private var loading = false
    @State private var showAddStudyItemView = false
    @State private var showingAlert = false
    @State private var alertMessage : String = ""
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            NavigationLink(destination: AddStudyItemView() {
                reloadStudyItems()
            },
                           isActive: $showAddStudyItemView) {
                EmptyView()
            }
            Color.memreLightGrey.ignoresSafeArea()
            List() {
                ForEach(studyItems, id: \.id) { studyItem in
                    StudyItemCell(studyItem: studyItem,
                                  isRecommended: isRecommended(studyItem))
                }
                .onDelete(perform: deleteStudyItem)
            }.refreshable {
                reloadAll()
            }.scrollContentBackground(.hidden)
            Button(action: {
                showAddStudyItemView = true
            }) {
                Image(systemName: "plus")
                    .scaledToFill()
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Color.memreRed)
                    .clipShape(Circle())
                    .padding(.trailing, 30)
            }
        }
        .overlay {
            if loading {
                ZStack {
                    Color(white: 0, opacity: 0.75).ignoresSafeArea()
                    ProgressView().tint(.white)
                }
            }
        }
        .navigationTitle("Study Items")
        .navigationBarItems(trailing: StatsBarButton())
        .onAppear {
            showAddStudyItemView = false
            reloadAll()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Oops"),
                  message: Text(alertMessage),
                  dismissButton: .cancel(Text("OK")))
        }
    }
    
    private func reloadAll() {
        reloadStudyItems()
        reloadRecommendedStudyItems()
    }
    
    private func reloadStudyItems() {
        self.studyItems = MyUserDefaults.getStudyItems()
    }
    
    private func isRecommended(_ studyItem: StudyItem) -> Bool {
        return self.recommendedStudyItemIds.contains(studyItem.learningEngineId)
    }
    
    private func reloadRecommendedStudyItems() {
        MemreLearningEngine.getRecommendedStudyItems(onCompletion: onGetRecommendedStudyItems,
                                                     onError: onGetRecommendedStudyItemsError)
    }
    
    private func onGetRecommendedStudyItems(studyItemIds: [String]) {
        self.recommendedStudyItemIds = studyItemIds
    }

    private func onGetRecommendedStudyItemsError(errorMessage: String) {
        alertMessage = errorMessage
        showingAlert = true
    }
    
    private func deleteStudyItem(at offsets: IndexSet) {
        offsets.forEach { index in
            MyUserDefaults.deleteStudyItem(studyItems[index])
        }
        studyItems.remove(atOffsets: offsets)
    }
}

struct StudyItemsView_Previews: PreviewProvider {
    
    static var previews: some View {
        return StudyItemsView(studyItems: [StudyItem.previewStudyItem()])
    }
}
