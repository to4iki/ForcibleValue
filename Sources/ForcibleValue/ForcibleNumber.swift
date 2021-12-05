/// Type that forcible decodes to NumericType.
///
/// The values of `LosslessStringConvertible` and `String` can be decoded.
@propertyWrapper
public struct ForcibleNumber<T: LosslessStringConvertible & Codable>: Codable, CustomStringConvertible {
    public var wrappedValue: T

    public var description: String {
        wrappedValue.description
    }

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
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
                    debugDescription: "Could not decode incoming value to \(T.self). It is not a type of \(T.self) or String."
                )
            )
        }
    }
}

public typealias ForcibleDouble = ForcibleNumber<Double>
public typealias ForcibleFloat = ForcibleNumber<Float>
public typealias ForcibleInt = ForcibleNumber<Int>
public typealias ForcibleInt8 = ForcibleNumber<Int8>
public typealias ForcibleInt16 = ForcibleNumber<Int16>
public typealias ForcibleInt32 = ForcibleNumber<Int32>
public typealias ForcibleInt64 = ForcibleNumber<Int64>
public typealias ForcibleUInt = ForcibleNumber<UInt>
public typealias ForcibleUInt8 = ForcibleNumber<UInt8>
public typealias ForcibleUInt16 = ForcibleNumber<UInt16>
public typealias ForcibleUInt32 = ForcibleNumber<UInt32>
public typealias ForcibleUInt64 = ForcibleNumber<UInt64>
