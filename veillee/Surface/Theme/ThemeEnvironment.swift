import SwiftUI

private struct ThemeKey: EnvironmentKey {
    static let defaultValue: Theme = .hearth
}

extension EnvironmentValues {
    /// The live theme, injected once by `ThemedRoot` and read by every Surface view.
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}
