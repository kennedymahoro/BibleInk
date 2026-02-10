struct VerseSpan: View {
    let verseID: String
    let number: Int
    let content: String
    
    var body: some View {
        // We use an AttributedString or standard Text
        (Text("\(number) ").font(.caption).foregroundColor(.secondary) + 
         Text(content))
            .background(VerseAnchorPreference(id: verseID)) // This "tags" the location
    }
}