///  Generic protocol for Forcible Decode type
public protocol ForcibleValue: Decodable, CustomStringConvertible, Equatable, Hashable {
    associatedtype Value: Decodable & CustomStringConvertible & Equatable & Hashable
    var wrappedValue: Value { get }
}
