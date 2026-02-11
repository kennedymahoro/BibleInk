import SwiftData
import SwiftUI

struct BibleReaderView: View {
    // 1. Fetching logic
    @State private var verses: [Verse] = []

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(verses) { verse in
                        // 2. The custom row that handles drawing
                        VerseRowView(verse: verse)

                        Divider()
                            .padding(.leading)
                    }
                }
            }
            .navigationTitle("John 1")
            .onAppear {
                // 3. Load the data from your SQLite DatabaseManager
                self.verses = DatabaseManager.shared.fetchChapter(book: "John", chapter: 1)
            }
        }
    }
}
