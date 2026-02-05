PRD: Bible Annotator (iPadOS)
1. Executive Summary
A specialized Bible study tool for iPad designed for deep academic and devotional study. The app prioritizes a "paper-like" experience where annotations are physically tethered to specific verses, regardless of scrolling or screen resizing.

2. Functional Requirements
A. Core Bible Reader
Primary Translation: NRSVue (Loaded via API or Local SQLite).

Interlinear Support: A Navbar toggle for "Split View."

Dropdown menu to select a secondary version (Greek/Hebrew or another translation).

Synchronized scrolling: Scrolling the primary view also scrolls the secondary view.

B. Navigation (The "Quick-Jump" Sidebar)
Trigger: A simple toggle button in the top-left navigation bar.

Structure: * Vertical list of Books (Genesis to Revelation).

Interaction: Clicking a Book expands a dropdown of Chapter numbers.

Action: Tapping a Chapter dismisses the sidebar and jumps the main reader to that section.

C. The "Tethered" Annotation Engine (Crucial)
Automatic Activation: Drawing is always "ON" when the Apple Pencil touches the screen.

Gesture Distinction: * Apple Pencil: Exclusively for drawing/annotating.

Fingers: Exclusively for scrolling and UI interaction.

Tethering Logic: Annotations must not be a single floating layer. Each verse acts as a "container."

Implementation: Each verse row contains its own PKCanvasView.

As the verse moves up/down during a scroll, the canvas moves with it.

3. Technical Architecture (For Antigravity Agents)
A. Data Schema (SQLite)
Table Verses: id, book, chapter, verse, content.

Table Annotations: id, verse_id_link, drawing_data (BLOB).

Logic: On verse appear, the app queries Annotations for the matching verse_id_link and populates the local PKCanvasView.

B. UI Stack
Framework: SwiftUI + NavigationSplitView.

Drawing: PencilKit wrapped in UIViewRepresentable.

Scroll Handling: LazyVStack or ScrollViewReader to ensure performance across 31,000+ verses.

4. Design Specifications
Minimalism: The text should be the focus. The Navbar should stay hidden or auto-hide to maximize the "study" space.

Split View: When active, the screen should split 50/50. Left: Main Translation. Right: Selected Version/Manuscript.

Pen Policy: Set canvasView.drawingPolicy = .pencilOnly. This ensures fingers don't accidentally smudge or draw while scrolling.

5. High-Level AI Implementation Prompt
Copy and paste this into Antigravity to begin the build:

"Act as a Senior iOS Engineer. I want to build a Bible app for iPad. Use SwiftData and PencilKit.

Create a Sidebar navigation with a list of Books and dropdown Chapters.

Implement a Main View where each Bible Verse is a row.

Critical: Every verse row must have a transparent PKCanvasView overlaid. Drawings made on a verse must stay with that verse when scrolling.

Ensure Apple Pencil is for drawing and fingers are for scrolling.

Add a Split View toggle in the toolbar to show two different Bible versions side-by-side."
