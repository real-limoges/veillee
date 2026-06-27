import Foundation

struct GenOptions: Equatable {
    var temperature: Double = 0.7
    var maxTokens: Int = 1_200

    static let `default` = GenOptions()
}

// The mapping lives next to the engine, the only place that knows FM exists.
import FoundationModels
extension GenOptions {
    var resolved: GenerationOptions {
        GenerationOptions(temperature: temperature, maximumResponseTokens: maxTokens)
    }
}
