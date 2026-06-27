import SwiftUI

extension Color {
    /// 0xRRGGBB convenience, private to the theme palette — the only place raw hex lives.
    fileprivate init(hex: UInt32) {
        self.init(
            red:   Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue:  Double(hex & 0xFF) / 255
        )
    }
}

extension Theme {
    /// Warm fireside: serif message text, ember accent, filled bubbles.
    static let hearth = Theme(
        background:      Color(hex: 0x17130F),
        surface:         Color(hex: 0x221A12),
        text:            Color(hex: 0xEFE3D2),
        secondaryText:   Color(hex: 0x9A8C7A),
        accent:          Color(hex: 0xE8A04B),
        accentSoft:      Color(hex: 0xE8A04B).opacity(0.18),
        userBubble:      Color(hex: 0xE8A04B).opacity(0.18),
        assistantBubble: Color(hex: 0x221A12),
        divider:         Color(hex: 0xEFE3D2).opacity(0.08),
        glow:            Color(hex: 0xFF7A3C),
        messageFont:     .system(.body, design: .serif),
        uiFont:          .system(.body),
        metadataFont:    .system(.caption),
        bubble:          .filled
    )

    /// Cool house palette: SF throughout, monospaced metadata, filled bubbles.
    static let tokyonight = Theme(
        background:      Color(hex: 0x1A1B26),
        surface:         Color(hex: 0x24283B),
        text:            Color(hex: 0xC0CAF5),
        secondaryText:   Color(hex: 0x787C99),
        accent:          Color(hex: 0x7AA2F7),
        accentSoft:      Color(hex: 0x7AA2F7).opacity(0.20),
        userBubble:      Color(hex: 0x7AA2F7).opacity(0.20),
        assistantBubble: Color(hex: 0x24283B),
        divider:         Color(hex: 0xC0CAF5).opacity(0.08),
        glow:            Color(hex: 0xBB9AF7),
        messageFont:     .system(.body),
        uiFont:          .system(.body),
        metadataFont:    .system(.caption, design: .monospaced),
        bubble:          .filled
    )

    /// Minimal: near-monochrome, no bubble fills — type and space do the work.
    static let quiet = Theme(
        background:      Color(hex: 0x0E0E10),
        surface:         Color(hex: 0x0E0E10),
        text:            Color(hex: 0xE6E6E8),
        secondaryText:   Color(hex: 0x6B6B70),
        accent:          Color(hex: 0x8A8AFF),
        accentSoft:      Color(hex: 0x8A8AFF).opacity(0.16),
        userBubble:      .clear,
        assistantBubble: .clear,
        divider:         Color(hex: 0xE6E6E8).opacity(0.06),
        glow:            Color(hex: 0x8A8AFF),
        messageFont:     .system(.body),
        uiFont:          .system(.body),
        metadataFont:    .system(.caption),
        bubble:          .plain
    )
}
