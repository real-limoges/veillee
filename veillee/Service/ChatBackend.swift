import Foundation       // not the FoundationModels, more generic

protocol ChatBackend {
    /// Stream replies to `input`. Yield value to full assistant text (accumulating)
    /// UI can swap the in-flight message with latest value

    func reply(
      to input: String,
      history: [Message],
      system: String,
      options: GenOptions
    ) -> AsyncThrowingStream<String, Error>
}
