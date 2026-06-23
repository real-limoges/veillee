# Veillée

A native macOS chat client for Apple's **Foundation Models** framework — the on-device model behind Apple Intelligence. No downloads, no Python, no Electron.

> **Veillée** *(n., Québécois French)* — an evening gathering where people sit and talk by the fire. A quiet, local conversation, held at home.

It's a single-window SwiftUI app. The model is a sealed, solved problem; the point of the project is the interface — the local-LLM chat client I actually want to look at and use.

## Stack

- **SwiftUI + SwiftData**, modern Swift concurrency (`async`/`await`, `AsyncStream`, `@Observable`)
- **Foundation Models** as the inference backend (~3B on-device model, guided generation, tool calling)
- **macOS 26** (developer beta) · Apple Silicon · built in Xcode

## Architecture

Four layers, with care concentrated at the surface and the seam just below it:

| Layer | Folder | Role |
|-------|--------|------|
| Surface (SwiftUI) | `Veillee/Surface` | `ConversationListView` · `ChatView` · `ComposerView` · `InspectorView` |
| Service seam | `Veillee/Service` | `ChatBackend` (protocol) · `ChatEngine` · `ToolRegistry` · `PromptStore` |
| Foundation Models | — | sealed, Apple's: streaming, `@Generable` output, tool calling |
| Persistence | `Veillee/Persistence` | `Conversation` · `Message` (SwiftData `@Model`) |

**The one rule:** keep the service seam thin. `ChatEngine` wraps `LanguageModelSession` and exposes nothing upward but a stream of tokens — no `FoundationModels` types leak into the views. That boundary is what lets the backend be swapped (e.g. mlx-swift) without touching the UI.

## Build order

1. Spike the engine — prove token streaming on the beta.
2. Single conversation, in memory — get the core loop's feel right.
3. Add SwiftData — conversation list, hydrate transcript on open.
4. Design pass — typography, motion, density, spacing.
5. Optional — `@Generable` tools rendered as native UI.
