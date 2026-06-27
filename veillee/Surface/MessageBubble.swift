import SwiftUI

struct MessageBubble: View {
    @Environment(\.theme) private var theme
    let message: Message
    var isStreaming = false

    @State private var caretOpacity: Double = 1

    private var isUser: Bool { message.role == .user }

    var body: some View {
        switch theme.bubble {
        case .filled: filled
        case .plain:  plain
        }
    }

    /// Text + a pulsing caret while tokens arrive. The caret is a concatenated
    /// fragment so it stays glued to the end of the (possibly wrapped) text.
    private var content: Text {
        let base = Text(message.content)
          .font(theme.messageFont)
          .foregroundStyle(theme.text)
        guard isStreaming else { return base }
        return base + Text("▍")
          .font(theme.messageFont)
          .foregroundStyle(theme.accent.opacity(caretOpacity))
    }

    /// Shared by both treatments, so caret, selection, font, and the per-token
    /// content animation stay identical.
    private var messageText: some View {
        content
          .textSelection(.enabled)
          .animation(.snappy(duration: 0.12), value: message.content)
          .task(id: isStreaming) {
              caretOpacity = 1
              guard isStreaming else { return }
              withAnimation(.easeInOut(duration: 0.55).repeatForever(autoreverses: true)) {
                  caretOpacity = 0.2
              }
          }
    }

    // Hearth / Tokyonight: rounded fills, user trailing, assistant leading.
    private var filled: some View {
        messageText
          .padding(.horizontal, 14).padding(.vertical, 10)
          .background(isUser ? theme.userBubble : theme.assistantBubble)
          .clipShape(.rect(cornerRadius: 14))
          .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
    }

    // Quiet: no fill — a dim role label and alignment carry the distinction.
    private var plain: some View {
        VStack(alignment: isUser ? .trailing : .leading, spacing: 4) {
            Text(isUser ? "You" : "Veillée")
              .font(theme.metadataFont)
              .foregroundStyle(theme.secondaryText)
            messageText
              .multilineTextAlignment(isUser ? .trailing : .leading)
        }
        .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
    }
}
