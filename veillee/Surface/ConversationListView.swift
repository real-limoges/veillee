import SwiftUI
import SwiftData

struct ConversationListView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.theme) private var theme
    @Query(sort: \Conversation.createdAt, order: .reverse) private var conversations: [Conversation]
    @State private var selection: Conversation?

    var body: some View {
        NavigationSplitView {
            List(conversations, selection: $selection) { convo in
                Text(convo.title)
                  .font(theme.uiFont)
                  .foregroundStyle(theme.text)
                  .tag(convo)
            }
            .scrollContentBackground(.hidden)
            .background(theme.surface)
            .navigationTitle("Veillée")
        } detail: {
            if let convo = selection {
                // Rebuild a fresh view-model from stored messages each time a thread opens.
                ChatView(model: ChatViewModel(engine: ChatEngine(), conversation: convo, context: context))
                    .id(convo.id)
            } else {
                ContentUnavailableView("No conversation", systemImage: "bubble.left.and.bubble.right")
            }
        }
        // Window-level placement so New sits in the wide toolbar area, always
        // visible — never collapsed into the sidebar's `»` overflow.
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("New", systemImage: "square.and.pencil", action: newConversation)
                  .keyboardShortcut("n", modifiers: .command)
            }
        }
    }

    private func newConversation() {
        let convo = Conversation()
        context.insert(convo)
        selection = convo
    }
}
