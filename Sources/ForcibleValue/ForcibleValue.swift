///  Generic protocol for Forcible Decode type
public protocol ForcibleValue: Decodable, CustomStringConvertible, Equatable {
  associatedtype Value: Decodable & CustomStringConvertible & Equatable
  var wrappedValue: Value { get }
}
