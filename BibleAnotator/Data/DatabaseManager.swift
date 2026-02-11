import Foundation
import SQLite3

class DatabaseManager {
    static let shared = DatabaseManager()
    var db: OpaquePointer?

    private init() {
        openDatabase()
    }

    func openDatabase() {
        let dbName = "BibleAnnotator.sqlite"
        let fileManager = FileManager.default

        do {
            // 1. Get the path to the "Application Support" directory
            let appSupportDir = try fileManager.url(
                for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil,
                create: true)
            let destinationURL = appSupportDir.appendingPathComponent(dbName)

            // 2. If the file doesn't exist in Application Support, copy it from the Bundle
            if !fileManager.fileExists(atPath: destinationURL.path) {
                if let bundleURL = Bundle.main.url(
                    forResource: "BibleAnnotator", withExtension: "sqlite")
                {
                    try fileManager.copyItem(at: bundleURL, to: destinationURL)
                    print("✅ Database copied to Application Support")
                } else {
                    print("❌ Error: BibleAnnotator.sqlite not found in Bundle")
                }
            }

            // 3. Open the connection to the writable copy
            if sqlite3_open(destinationURL.path, &db) != SQLITE_OK {
                print("❌ Error opening database")
            } else {
                print("📖 Database opened at: \(destinationURL.path)")
            }

        } catch {
            print("❌ File Manager error: \(error)")
        }
    }
    func fetchVerse(verseID: String) -> String? {
        let query = "SELECT content FROM verses WHERE verse_id = ?;"
        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            // Bind the verse_id to the '?' in the query
            sqlite3_bind_text(statement, 1, (verseID as NSString).utf8String, -1, nil)

            if sqlite3_step(statement) == SQLITE_ROW {
                let content = String(cString: sqlite3_column_text(statement, 0))
                sqlite3_finalize(statement)
                return content
            }
        }
        sqlite3_finalize(statement)
        return nil
    }
    func fetchChapter(book: String, chapter: Int) -> [Verse] {
        var verses: [Verse] = []
        let query = "SELECT * FROM verses WHERE book = ? AND chapter = ? ORDER BY verse_number;"
        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            // Bind the parameters
            sqlite3_bind_text(statement, 1, (book as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 2, Int32(chapter))

            // Loop through results
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = String(cString: sqlite3_column_text(statement, 0))
                let verse_id = String(cString: sqlite3_column_text(statement, 1))
                let book = String(cString: sqlite3_column_text(statement, 2))
                let chapter = Int(sqlite3_column_int(statement, 3))
                let verseNum = Int(sqlite3_column_int(statement, 4))
                let text = String(cString: sqlite3_column_text(statement, 5))

                let verse = Verse(
                    id: id, verse_id: verse_id, book: book, chapter: chapter,
                    verse_number: verseNum, content: text)
                verses.append(verse)
            }
        }
        sqlite3_finalize(statement)
        return verses
    }
}
