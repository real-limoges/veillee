import FoundationModels

final class ChatEngine: ChatBackend {

    func reply(
      to input: String,
      history: [Message],
      system: String,
      options: GenOptions
    ) -> AsyncThrowingStream<String, Error> {
        AsyncThrowingStream { continuation in
            let task = Task { await drain(input, history, system, options, into: continuation) }
            // tear down stream cancels the task
            continuation.onTermination = { _ in task.cancel() }
        }
    }

    private func drain(
      _ input: String, _ history: [Message], _ system: String, _ options: GenOptions,
      into continuation: AsyncThrowingStream<String, Error>.Continuation
    ) async {
        do {
            let session = LanguageModelSession(transcript: Self.transcript(system: system, history: history))
            for try await partial in session.streamResponse(to: input, options: options.resolved) {
                continuation.yield(partial.content)
            }
            continuation.finish()
        } catch {
            continuation.finish(throwing: error)
        }
    }

    private static func transcript(system: String, history: [Message]) -> Transcript {
        func segments(_ text: String) -> [Transcript.Segment] { [.text(.init(content: text))] }

        var entries: [Transcript.Entry] = [
            .instructions(.init(segments: segments(system), toolDefinitions: []))
        ]
        for m in history {
            switch m.role {
            case .user:         entries.append(.prompt(.init(segments: segments(m.content))))
            case .assistant:    entries.append(.response(.init(assetIDs: [], segments: segments(m.content))))
            case .system:       break
            }
        }
        return Transcript(entries: entries)
    }
}
