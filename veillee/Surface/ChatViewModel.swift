import Foundation
import SwiftData

@Observable
final class ChatViewModel {
    private(set) var messages: [Message] = []
    private(set) var isStreaming = false

    private let engine: ChatBackend
    private let conversation: Conversation
    private let context: ModelContext
    private var streamTask: Task<Void, Never>?
    private let system: String

    init(engine: ChatBackend, conversation: Conversation, context: ModelContext) {
        self.engine = engine
        self.conversation = conversation
        self.context = context
        self.system = conversation.systemPrompt
        // Seed from stored messages so a reopened thread shows its history.
        self.messages = conversation.messages.sorted { $0.timestamp < $1.timestamp }
    }

    func send(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, !isStreaming else { return }

        let history = messages

        let user = Message(role: .user, content: trimmed)
        user.conversation = conversation
        context.insert(user)
        messages.append(user)

        let assistant = Message(role: .assistant, content: "")
        assistant.conversation = conversation
        context.insert(assistant)
        messages.append(assistant)

        isStreaming = true
        streamTask = Task { await stream(trimmed, history: history, into: assistant) }
    }

    func stop() { streamTask?.cancel() }

    private func stream(_ input: String, history: [Message], into assistant: Message) async {
        defer { isStreaming = false }
        let replies = engine.reply(to: input, history: history, system: system, options: .default)
        do {
            for try await snapshot in replies {
                assistant.content = snapshot
            }
        } catch is CancellationError {
            // Stop pressed — keep whatever streamed so far.
        } catch {
            assistant.content = error.localizedDescription
        }
    }
}
