import SwiftUI

struct ChatView: View {
    @Environment(\.theme) private var theme
    @Bindable var model: ChatViewModel

    var body: some View {
        ScrollViewReader { proxy in
            transcript
              .onChange(of: model.messages.last?.content) { _, _ in
                  withAnimation { proxy.scrollTo(model.messages.last?.id, anchor: .bottom) }
              }
        }
          .background(theme.background)
          .safeAreaInset(edge: .bottom) { ComposerView(model: model) }
    }

    private var transcript: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 12) {
                ForEach(model.messages) { message in
                    MessageBubble(
                        message: message,
                        isStreaming: model.isStreaming && message.id == model.messages.last?.id
                    )
                    .id(message.id)
                    // New turns fade and rise into place.
                    .transition(.asymmetric(
                        insertion: .opacity.combined(with: .offset(y: 10)),
                        removal: .opacity
                    ))
                }
            }
            .padding()
            .animation(.snappy(duration: 0.28), value: model.messages.count)
        }
        .scrollContentBackground(.hidden)
    }
}
