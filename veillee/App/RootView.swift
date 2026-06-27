import SwiftUI
import FoundationModels   // allowed because it's App layer, not Surface

struct RootView: View {
    private let model = SystemLanguageModel.default

    var body: some View {
        switch model.availability {
        case .available:
            ConversationListView()
        case .unavailable(.appleIntelligenceNotEnabled):
            Unavailable("Enable Apple Intelligence in System Settings to use Veillée.")
        case .unavailable(.deviceNotEligible):
            Unavailable("This device can't run the on-device model.")
        case .unavailable(.modelNotReady):
            Unavailable("The model is still downloading. This finishes in the background.")
        case .unavailable:
            Unavailable("No model available right now.")
        }
    }
}

/// Written empty-state just like the rest of the app. No spinner.
struct Unavailable: View {
    let message: String
    init(_ message: String) { self.message = message }
    var body: some View {
        ContentUnavailableView("No model", systemImage: "moon.zzz", description: Text(message))
    }
}
