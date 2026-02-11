import PencilKit
import SwiftData
import SwiftUI

struct VerseRowView: View {
    let verse: Verse

    // 4. SwiftData Query: This looks for a drawing matching this specific verse ID
    @Query var annotations: [Annotation]
    @Environment(\.modelContext) private var modelContext

    init(verse: Verse) {
        self.verse = verse
        let id = verse.id
        // Filter query so this row only sees its own drawing
        _annotations = Query(filter: #Predicate<Annotation> { $0.verseID == id })
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Layer 1: The Scripture Text
            VStack(alignment: .leading, spacing: 8) {
                Text(verse.content)
                    .font(.system(.body, design: .serif))
                    .lineSpacing(6)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)

            // Layer 2: The Drawing Canvas
            CanvasView(
                drawing: Binding(
                    get: {
                        if let data = annotations.first?.drawingData {
                            return (try? PKDrawing(data: data)) ?? PKDrawing()
                        }
                        return PKDrawing()
                    },
                    set: { newDrawing in
                        saveDrawing(newDrawing)
                    }
                ))
        }
        // Ensure the row is tall enough to be drawn on
        .contentShape(Rectangle())
    }

    private func saveDrawing(_ drawing: PKDrawing) {
        let data = drawing.dataRepresentation()
        if let existing = annotations.first {
            existing.drawingData = data
        } else {
            let newAnnotation = Annotation(verseID: verse.id, drawingData: data)
            modelContext.insert(newAnnotation)
        }
    }
}
