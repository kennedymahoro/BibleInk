import Foundation

public struct Verse: Identifiable, Codable {
    public let id: String
    public let book: String
    public let chapter: Int
    public let verseNumber: Int
    public let text: String

    public init(id: String, book: String, chapter: Int, verseNumber: Int, text: String) {
        self.id = id
        self.book = book
        self.chapter = chapter
        self.verseNumber = verseNumber
        self.text = text
    }
}
