# Bible Annotator (iPadOS)

Bible Annotator is a specialized Bible study tool for iPad designed for deep academic and devotional study. The app focuses on a "paper-like" experience where handwritten annotations are physically tethered to specific verses, ensuring your notes stay exactly where they belong regardless of scrolling or screen resizing.

## Key Features

- **Tethered Annotations**: 
  - Annotations act as a container per verse rather than a single floating layer.
  - Drawings are "tethered" to specific verses, moving with the text during scrolling.
  - Optimized for Apple Pencil (drawing) and touch (scrolling).

- **Core Bible Reader**:
  - Clean, minimalist reading interface focusing on the text.
  - Primary Translation: NRSVue.
  - "Split View" Support: Toggle a secondary pane to view Greek/Hebrew manuscripts or other translations side-by-side with synchronized scrolling.

- **Seamless Navigation**:
  - "Quick-Jump" Sidebar for rapid access to any Book and Chapter.
  - Expandable book lists with chapter selection.

## Technical Stack

- **Platform**: iPadOS
- **Frameworks**: SwiftUI, PencilKit, SwiftData / SQLite
- **Architecture**: 
  - `PKCanvasView` embedded in `UIViewRepresentable` for each verse row to handle tethering.
  - `drawingPolicy = .pencilOnly` to separate navigation gestures from annotation.

## Getting Started

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   ```

2. **Open in Xcode**:
   - Open `BibleAnotator.xcodeproj` or `.xcworkspace`.

3. **Build and Run**:
   - Select an iPad Simulator or connected iPad device.
   - Build and run the project (`Cmd + R`).

## Requirements

- **Xcode**: Latest version recommended.
- **Target OS**: iPadOS 17.0+.
- **Hardware**: iPad with Apple Pencil support is highly recommended for the full annotation experience.
