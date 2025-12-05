// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public struct NonCodableType {
    public let value: String

    public init(value: String) {
        self.value = value
    }
}

/// Helper object allowing to decode Date using ISO8601 scheme
public struct CustomConfig: DecodingConfigurationProviding, EncodingConfigurationProviding, Sendable {
    public static let encodingConfiguration = CustomConfig()
    public static let decodingConfiguration = CustomConfig()

    func decode(from decoder: any Decoder) throws -> NonCodableType {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        return NonCodableType(value: value)
    }

    func encode(object: NonCodableType, to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(object.value)
    }
}

extension NonCodableType: CodableWithConfiguration {
    public init(from decoder: any Decoder, configuration: CustomConfig) throws {
        self = try configuration.decode(from: decoder)
    }

    public func encode(to encoder: any Encoder, configuration: CustomConfig) throws {
        try configuration.encode(object: self, to: encoder)
    }
}
