import SwiftData
import SwiftUI

@main
struct BibleAnotatorApp: App {
    var body: some Scene {
        WindowGroup {
            BibleReaderView()
        }
    }
}

#Preview {
    BibleReaderView()
}
