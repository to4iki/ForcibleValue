///  Generic protocol for default value sources
public protocol ForcibleDefaultSource {
    associatedtype DefaultValue: ForcibleValue
    static var defaultValue: DefaultValue { get }
}
