
import SwiftUI

struct RootNavigation: View {
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.memreRed]
    }
    
    var body: some View {
        NavigationStack {
            EnterAPIKeyView()
        }
        .accentColor(Color.memreRed)
    }
}

struct RootNavigation_Previews: PreviewProvider {
    
    static var previews: some View {
        RootNavigation()
    }
}
