
import SwiftUI

struct RootNavigation: View {
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.primaryRed]
    }
    
    var body: some View {
        NavigationStack {
            EnterAPIKeyView()
        }
        .accentColor(Color.primaryRed)
    }
}

struct RootNavigation_Previews: PreviewProvider {
    
    static var previews: some View {
        RootNavigation()
    }
}
