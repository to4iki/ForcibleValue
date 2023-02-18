/// Namespace for the default value decoding code
public enum ForcibleDefault {}

extension ForcibleDefault {
    @propertyWrapper
    public struct Wrapper<T: ForcibleDefaultSource>: Decodable, CustomStringConvertible, Equatable, Hashable {
        public typealias Value = T.DefaultValue.Value
        public var wrappedValue: Value

        public var description: String {
            wrappedValue.description
        }

        public init(wrappedValue: Value) {
            self.wrappedValue = wrappedValue
        }

        public init(from decoder: Decoder) throws {
            self.wrappedValue = try T.DefaultValue.init(from: decoder).wrappedValue
        }
    }
}

extension KeyedDecodingContainer {
    public func decode<T>(_ type: ForcibleDefault.Wrapper<T>.Type, forKey key: Key) throws -> ForcibleDefault.Wrapper<T> where T: ForcibleDefaultSource {
        try decodeIfPresent(type, forKey: key) ?? .init(wrappedValue: T.defaultValue.wrappedValue)
    }
}

extension ForcibleDefault {
    public typealias EmptyString = Wrapper<Sources.EmptyString>
    public typealias True = Wrapper<Sources.True>
    public typealias False = Wrapper<Sources.False>
    public typealias Zero<T: ForcibleNumberSource> = Wrapper<Sources.Zero<T>>

    public enum Sources {
        public enum EmptyString: ForcibleDefaultSource {
            public static var defaultValue: ForcibleString {
                .init(wrappedValue: "")
            }
        }

        public enum True: ForcibleDefaultSource {
            public static var defaultValue: ForcibleBool {
                .init(wrappedValue: true)
            }
        }

        public enum False: ForcibleDefaultSource {
            public static var defaultValue: ForcibleBool {
                .init(wrappedValue: false)
            }
        }

        public enum Zero<T: ForcibleNumberSource>: ForcibleDefaultSource {
            public static var defaultValue: ForcibleNumber<T> {
                .init(wrappedValue: 0)
            }
        }
    }
}
