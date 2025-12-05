import Testing
import Foundation
@testable import CodableConfiguration

struct CustomConfigTests {

    // MARK: Direct DecodingConfigurationProviding decoding

    @Test
    func decodingDirectly_succeedsForNull() async throws {
        let json = "null"
        let jsonData = try #require(json.data(using: .utf8))

        let decoder = JSONDecoder()
        let sut = try decoder.decode(NonCodableType?.self, from: jsonData, configuration: CustomConfig.decodingConfiguration)
        #expect(sut == nil)
    }

    @Test
    func decodingDirectly_succeedsForCorrectValue() async throws {
        let json = "\"Hello There\""
        let jsonData = try #require(json.data(using: .utf8))

        let decoder = JSONDecoder()
        let sut = try decoder.decode(NonCodableType?.self, from: jsonData, configuration: CustomConfig.decodingConfiguration)
        #expect(sut?.value == "Hello There")
    }

    // MARK: Indirect DecodingConfigurationProviding decoding

    @Test
    func decodingIndirectly_succeedsForNull() async throws {
        let json = "{\"testObject\": null}"
        let jsonData = try #require(json.data(using: .utf8))

        let decoder = JSONDecoder()
        let sut = try decoder.decode(TestModel.self, from: jsonData)
        #expect(sut.testObject == nil)
    }

    @Test
    func decodingIndirectly_succeedsForCorrectDate() async throws {
        let json = "{\"testObject\":\"Hello There\"}"
        let jsonData = try #require(json.data(using: .utf8))

        let decoder = JSONDecoder()
        let sut = try decoder.decode(TestModel.self, from: jsonData)
        #expect(sut.testObject?.value == "Hello There")
    }

    @Test
    func decodingIndirectly_succeedsForMissingKey() async throws {
        let json = "{}"
        let jsonData = try #require(json.data(using: .utf8))

        let decoder = JSONDecoder()
        let sut = try decoder.decode(TestModel.self, from: jsonData)
        #expect(sut.testObject == nil)
    }
}

private extension CustomConfigTests {
    struct TestModel: Codable {
        @CodableConfiguration(wrappedValue: nil, from: CustomConfig.self)
        var testObject: NonCodableType?
    }
}
