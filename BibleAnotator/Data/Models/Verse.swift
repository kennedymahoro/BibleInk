import Foundation

public struct Verse: Identifiable, Codable {
    public let id: String
    public let verse_id: String
    public let book: String
    public let chapter: Int
    public let verse_number: Int
    public let content: String

    public init(
        id: String, verse_id: String, book: String, chapter: Int, verse_number: Int, content: String
    ) {
        self.id = id
        self.verse_id = verse_id
        self.book = book
        self.chapter = chapter
        self.verse_number = verse_number
        self.content = content
    }
}
