import SwiftUI

struct ComposerView: View {
    @Environment(\.theme) private var theme
    @Bindable var model: ChatViewModel
    @State private var draft = ""

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            TextField("Message", text: $draft, axis: .vertical)
              .textFieldStyle(.plain)
              .font(theme.uiFont)
              .foregroundStyle(theme.text)
              .lineLimit(1...6)
              .onSubmit(send)
              .padding(.horizontal, 12)
              .padding(.vertical, 8)
              // The input is a floating rounded field, not a full-width bar — so
              // nothing contrasting peeks out behind the floating sidebar's corner.
              .background(theme.surface, in: .rect(cornerRadius: 18))
              .overlay(
                  RoundedRectangle(cornerRadius: 18)
                    .strokeBorder(theme.divider, lineWidth: 1)
              )

            if model.isStreaming {
                Button("Stop", action: model.stop)
                  .keyboardShortcut(".", modifiers: .command)
            } else {
                Button("Send", action: send)
                  .keyboardShortcut(.return, modifiers: [])
                  .disabled(draft.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
          .padding(.horizontal, 12)
          .padding(.vertical, 10)
          // Match the transcript background so the area under the sidebar corner
          // is the same dark — no visible seam where sidebar meets composer.
          .background(theme.background)
    }

    private func send() {
        model.send(draft)
        draft = ""
    }
}
