///  Generic protocol for `ForcibleNumber` wrappedValue sources
public typealias ForcibleNumberSource = Numeric & LosslessStringConvertible & Decodable & Equatable

/// Type that forcible decodes to NumericType.
///
/// The values of `ForcibleNumberSource` and `String` can be decoded.
@propertyWrapper
public struct ForcibleNumber<T: ForcibleNumberSource>: ForcibleValue {
  public var wrappedValue: T

  public var description: String {
    wrappedValue.description
  }

  public init(wrappedValue: T) {
    self.wrappedValue = wrappedValue
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.singleValueContainer()

    if let value = try? container.decode(T.self) {
      self.wrappedValue = value
    } else if let string = try? container.decode(String.self) {
      if let value = T.init(string) {
        self.wrappedValue = value
      } else {
        throw DecodingError.typeMismatch(
          T.self,
          DecodingError.Context(
            codingPath: container.codingPath,
            debugDescription: "'\(string)' could not convert to \(T.self)."
          )
        )
      }
    } else {
      throw DecodingError.typeMismatch(
        T.self,
        DecodingError.Context(
          codingPath: container.codingPath,
          debugDescription:
            "Could not decode incoming value to \(T.self). It is not a type of \(T.self) or String."
        )
      )
    }
  }
}

// MARK: - ForcibleNumber.Option
extension ForcibleNumber {
  @propertyWrapper
  public struct Option: Decodable, CustomStringConvertible, Equatable {
    public var wrappedValue: T?

    public var description: String {
      wrappedValue?.description ?? Optional<T>.none.debugDescription
    }

    public init(wrappedValue: T?) {
      self.wrappedValue = wrappedValue
    }

    public init(from decoder: any Decoder) throws {
      self.wrappedValue = try ForcibleNumber(from: decoder).wrappedValue
    }
  }
}

extension KeyedDecodingContainer {
  public func decode<T>(_ type: ForcibleNumber<T>.Option.Type, forKey key: Key) throws
    -> ForcibleNumber<T>.Option
  {
    try decodeIfPresent(type, forKey: key) ?? ForcibleNumber<T>.Option(wrappedValue: nil)
  }
}
