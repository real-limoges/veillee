import SwiftUI

/// The app's Settings (⌘,) content. Theme selection lives here, not in the toolbar.
/// Writes the same @AppStorage key `ThemedRoot` reads, so changes re-theme instantly.
struct SettingsView: View {
    @AppStorage("themeID") private var rawID = ThemeID.hearth.rawValue

    var body: some View {
        Form {
            Picker("Theme", selection: $rawID) {
                ForEach(ThemeID.allCases) { id in
                    Text(id.displayName).tag(id.rawValue)
                }
            }
        }
        .formStyle(.grouped)
        .frame(width: 360)
    }
}
