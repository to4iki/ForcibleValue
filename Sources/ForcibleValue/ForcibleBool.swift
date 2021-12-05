/// Type that forcible decodes to `Bool`.
///
/// The values of `Bool`, `Int`, and `String` can be decoded.
@propertyWrapper
public struct ForcibleBool: Codable, CustomStringConvertible {
    public var wrappedValue: Bool

    public var description: String {
        wrappedValue.description
    }

    public init(wrappedValue: Bool) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let bool = try? container.decode(Bool.self) {
            self.wrappedValue = bool
        } else if let int = try? container.decode(Int.self) {
            if int == 0 {
                self.wrappedValue = false
            } else if int == 1 {
                self.wrappedValue = true
            } else {
                throw DecodingError.typeMismatch(
                    Bool.self,
                    DecodingError.Context(
                        codingPath: container.codingPath,
                        debugDescription: "'\(int)' could not convert to Bool."
                    )
                )
            }
        } else if let string = try? container.decode(String.self) {
            if let bool = Bool(string) {
                self.wrappedValue = bool
            } else {
                throw DecodingError.typeMismatch(
                    Bool.self,
                    DecodingError.Context(
                        codingPath: container.codingPath,
                        debugDescription: "'\(string)' could not convert to Bool."
                    )
                )
            }
        } else {
            throw DecodingError.typeMismatch(
                Bool.self,
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Could not decode incoming value to Bool. It is not a type of Bool, Int or String."
                )
            )
        }
    }
}
