///  Generic protocol for Forcible Decode type
public protocol ForcibleValue: Decodable, CustomStringConvertible, Equatable, Hashable {
    associatedtype Value: Decodable & CustomStringConvertible
    var wrappedValue: Value { get }
}
