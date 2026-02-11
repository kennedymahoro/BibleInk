import PencilKit
import SwiftUI

struct CanvasView: UIViewRepresentable {
    @Binding var drawing: PKDrawing

    func makeUIView(context: Context) -> PKCanvasView {
        let canvas = PKCanvasView()
        canvas.drawing = drawing
        canvas.tool = PKInkingTool(.pen, color: .black, width: 5)
        canvas.isUserInteractionEnabled = true
        return canvas
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.drawing = drawing
    }
}
