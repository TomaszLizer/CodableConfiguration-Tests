//
//  CustomDateDecodableTests.swift
//  TestCodableConfiguration
//
//  Created by Tomasz Lizer on 05/12/2025.
//

import Foundation
import CodableConfiguration
import Testing

struct OptionalISO8601DateTests {
    @Test
    func decoding_succeedsForCorrectDate() async throws {
        let json = "{\"testDate\":\"2025-12-04T07:49:09Z\"}"
        let jsonData = try #require(json.data(using: .utf8))

        let decoder = JSONDecoder()
        let sut = try decoder.decode(TestModel.self, from: jsonData)
        #expect(sut.testDate != nil)
    }

    @Test
    func decoding_succeedsForNull() async throws {
        let json = "{\"testDate\": null}"
        let jsonData = try #require(json.data(using: .utf8))

        let decoder = JSONDecoder()
        let sut = try decoder.decode(TestModel.self, from: jsonData)
        #expect(sut.testDate == nil)
    }

    @Test
    func decoding_succeedsForMissingKey() async throws {
        let json = "{}"
        let jsonData = try #require(json.data(using: .utf8))

        let decoder = JSONDecoder()
        let sut = try decoder.decode(TestModel.self, from: jsonData)
        #expect(sut.testDate == nil)
    }
}

private extension OptionalISO8601DateTests {
    struct TestModel: Codable {
        @OptionalISO8601Date
        var testDate: Date?
    }
}
