import Foundation
import SwiftData

@Model
final class Annotation {
    var verseID: String
    var drawingData: Data
    var createdAt: Date

    init(verseID: String, drawingData: Data) {
        self.verseID = verseID
        self.drawingData = drawingData
        self.createdAt = Date()
    }
}
