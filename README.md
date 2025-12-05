# CodableConfiguration-Tests

This repository demonstrates an inconsistency in Swift Foundation's `CodableConfiguration` decoding of optionals:

- **Standard behavior** (`Codable`, `DecodableWithConfiguration`): Missing or `null` value for an optional property decodes to `nil` without error.
- **CodableConfiguration issue**: Decoding an optional property from a `null` value triggers a decoding error (see the tests in this repository for a demonstration).

MIT License
