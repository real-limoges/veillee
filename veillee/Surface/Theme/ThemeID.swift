import Foundation

/// The persisted token. Its raw value is what lives in @AppStorage.
enum ThemeID: String, CaseIterable, Identifiable {
    case hearth, tokyonight, quiet

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .hearth:     "Hearth"
        case .tokyonight: "Tokyonight"
        case .quiet:      "Quiet"
        }
    }

    var theme: Theme {
        switch self {
        case .hearth:     .hearth
        case .tokyonight: .tokyonight
        case .quiet:      .quiet
        }
    }
}
