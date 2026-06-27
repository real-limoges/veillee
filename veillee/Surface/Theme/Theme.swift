import SwiftUI

/// How a message is drawn: rounded fills, or type-and-space.
enum BubbleTreatment { case filled, plain }

/// The semantic vocabulary every Surface view reads. Views ask for roles
/// (`theme.accent`), never palette names — so a view never knows which theme is live.
struct Theme: Equatable {
    // Colors — semantic roles
    var background: Color       // app/window base
    var surface: Color          // elevated panels: sidebar, composer bar
    var text: Color             // primary message/UI text
    var secondaryText: Color    // dim metadata, placeholders, role labels
    var accent: Color           // tint, send button, accent source
    var accentSoft: Color       // low-opacity accent for fills
    var userBubble: Color       // user message fill
    var assistantBubble: Color  // assistant message fill
    var divider: Color          // hairlines
    var glow: Color             // accent highlight (defaults to accent)

    // Typography
    var messageFont: Font       // the structural axis: serif for Hearth, SF elsewhere
    var uiFont: Font            // chrome and labels
    var metadataFont: Font      // small/dim text

    // Structure
    var bubble: BubbleTreatment
}
