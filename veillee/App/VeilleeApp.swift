import SwiftUI
import SwiftData

@main
struct VeilleeApp: App {
    var body: some Scene {
        WindowGroup { ThemedRoot { RootView() } }
          .modelContainer(for: [Conversation.self, Message.self])

        #if os(macOS)
        Settings {
            ThemedRoot { SettingsView() }
        }
        #endif
    }
}
