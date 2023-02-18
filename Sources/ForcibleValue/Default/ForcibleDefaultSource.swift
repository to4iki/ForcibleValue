///  Generic protocol for default value sources
public protocol ForcibleDefaultSource: Equatable, Hashable {
    associatedtype DefaultValue: ForcibleValue
    static var defaultValue: DefaultValue { get }
}
