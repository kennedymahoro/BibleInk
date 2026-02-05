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
            let appSupportDir = try fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let destinationURL = appSupportDir.appendingPathComponent(dbName)
            
            // 2. If the file doesn't exist in Application Support, copy it from the Bundle
            if !fileManager.fileExists(atPath: destinationURL.path) {
                if let bundleURL = Bundle.main.url(forResource: "BibleAnnotator", withExtension: "sqlite") {
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
}