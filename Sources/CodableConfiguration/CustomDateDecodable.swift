//
//  CustomDateDecodable.swift
//  TestCodableConfiguration
//
//  Created by Tomasz Lizer on 05/12/2025.
//

import Foundation

@propertyWrapper
public struct OptionalISO8601Date: Codable, Equatable, Hashable {
    public var wrappedValue: Date?

    nonisolated(unsafe) static let formatter = ISO8601DateFormatter()

    public init(wrappedValue: Date? = nil) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            return
        }
        let string = try container.decode(String.self)
        guard let date = Self.formatter.date(from: string) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date")
        }
        wrappedValue = date
    }

    public func encode(to encoder: Encoder) throws {
        guard let wrappedValue else { return }
        var container = encoder.singleValueContainer()
        try container.encode(Self.formatter.string(from: wrappedValue))
    }
}

public extension KeyedDecodingContainer {
    func decode(_: OptionalISO8601Date.Type, forKey key: Self.Key) throws -> OptionalISO8601Date {
        let wrapper = try decodeIfPresent(OptionalISO8601Date.self, forKey: key)
        return OptionalISO8601Date(wrappedValue: wrapper?.wrappedValue)
    }
}
