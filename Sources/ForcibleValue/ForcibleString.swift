/// Type that forcible decodes to `String`.
///
/// The values of `String`, `Int`, and `Double` can be decoded.
@propertyWrapper
public struct ForcibleString: ForcibleValue {
  public var wrappedValue: String

  public var description: String {
    wrappedValue.description
  }

  public init(wrappedValue: String) {
    self.wrappedValue = wrappedValue
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.singleValueContainer()

    if let string = try? container.decode(String.self) {
      self.wrappedValue = string
    } else if let int = try? container.decode(Int.self) {
      self.wrappedValue = String(int)
    } else if let double = try? container.decode(Double.self) {
      self.wrappedValue = String(double)
    } else {
      throw DecodingError.typeMismatch(
        String.self,
        DecodingError.Context(
          codingPath: container.codingPath,
          debugDescription:
            "Could not decode incoming value to String. It is not a type of String, Int or Double."
        )
      )
    }
  }
}

// MARK: - ForcibleString.Option
extension ForcibleString {
  @propertyWrapper
  public struct Option: Decodable, CustomStringConvertible, Equatable {
    public var wrappedValue: String?

    public var description: String {
      wrappedValue?.description ?? Optional<String>.none.debugDescription
    }

    public init(wrappedValue: String?) {
      self.wrappedValue = wrappedValue
    }

    public init(from decoder: any Decoder) throws {
      self.wrappedValue = try ForcibleString(from: decoder).wrappedValue
    }
  }
}

extension KeyedDecodingContainer {
  public func decode(_ type: ForcibleString.Option.Type, forKey key: Key) throws
    -> ForcibleString.Option
  {
    try decodeIfPresent(type, forKey: key) ?? ForcibleString.Option(wrappedValue: nil)
  }
}
