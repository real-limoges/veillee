import SwiftUI

/// Resolves the persisted theme and themes everything below it. Sits above `RootView`
/// so both the app and every empty-state inherit the palette, tint, and dark scheme.
struct ThemedRoot<Content: View>: View {
    @AppStorage("themeID") private var rawID = ThemeID.hearth.rawValue
    private let content: Content

    init(@ViewBuilder content: () -> Content) { self.content = content() }

    private var theme: Theme { (ThemeID(rawValue: rawID) ?? .hearth).theme }

    var body: some View {
        content
            .environment(\.theme, theme)
            .tint(theme.accent)
            .background(theme.background.ignoresSafeArea())
            .preferredColorScheme(.dark)
    }
}
