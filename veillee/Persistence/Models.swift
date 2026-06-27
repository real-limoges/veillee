import Foundation
import SwiftData

enum Role: String, Codable { case user, assistant, system }

@Model final class Conversation {
    var id: UUID = UUID()
    var title: String = "New conversation"
    var createdAt: Date = Date()
    var systemPrompt: String = "You are a concise, helpful assistant."

    @Relationship(deleteRule: .cascade, inverse: \Message.conversation)
    var messages: [Message] = []

    init() {}
}

@Model final class Message {
    var role: Role = Role.user
    var content: String = ""
    var timestamp: Date = Date()
    var conversation: Conversation?

    init(role: Role, content: String) {
        self.role = role
        self.content = content
    }
}
