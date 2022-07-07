# ForcibleValue

![Swift 5](https://img.shields.io/badge/swift-5-orange.svg)
![CocoaPods compatible](https://img.shields.io/cocoapods/v/ForcibleValue.svg)
![Carthage compatible](https://img.shields.io/badge/carthage-compatible-brightgreen.svg)
![SPM compatible](https://img.shields.io/badge/SPM-Compatible-brightgreen.svg)
![MIT License](https://img.shields.io/badge/license-MIT-brightgreen.svg)

Decode value that is sometimes an Int and other times a String your `Codable` structs through property wrappers.

## Installation

### Swift Package Manager

```swift
.package(url: "https://github.com/to4iki/ForcibleValue", from: "0.1.0")
```

### Cocoapods

```ruby
pod 'ForcibleValue'
```

### Carthage

```ruby
github "to4iki/ForcibleValue"
```

## Usage

You can define a variable of forcible type to decode your structs.

```swift
struct User: Decodable {
    @ForcibleString var name: String
    @ForcibleInt var age: Int
    @ForcibleDouble var height: Double
    @ForcibleFloat var weight: Float
    @ForcibleBool var isAdmin: Bool
}

let json = """
{
    "name": 1234,
    "age": "30",
    "height": "172.3",
    "weight": "60.0",
    "isAdmin": 1
}
""".data(using: .utf8)

do {
    let user = try JSONDecoder().decode(User.self, from: json!)
    print(user) // User(_name: 1234, _age: 30, _height: 172.3, _weight: 60.0, _isAdmin: true)
} catch {
    print(error)
}
```

### @ForcibleString.Option
`@ForcibleString.Option` is nil if the Decoder is unable to decode the value, either when nil is encountered or some unexpected type.

`ForcibleBool.Option` and `@ForcibleInt.Option` also have the same behavior, only the type that wraps is different.

```swift
struct Target: Decodable {
    @ForcibleString.Option var value1: String?
    @ForcibleString.Option var value2: String?
}

let json = #"{ "value1": 1 }"#.data(using: .utf8)!
let target = try! JSONDecoder().decode(Target.self, from: json)

print(target) // Target(_value1: 1, _value2: nil)
```

### @ForcibleDefault
`@ForcibleDefault` provides a generic property wrapper that allows default values using a custom ForcibleDefaultSource protocol.  
Below are a few common default source.

#### @ForcibleDefault.EmptyString
`@ForcibleDefault.EmptyString` returns an empty string instead of nil if the Decoder is unable to decode the container. 

```swift
struct Target: Decodable {
    @ForcibleDefault.EmptyString var value1: String
    @ForcibleDefault.EmptyString var value2: String
}

let json = #"{ "value1": 1 }"#.data(using: .utf8)!
let target = try! JSONDecoder().decode(Target.self, from: json)
print(target) // Target(_value1: 1, _value2: )
```

#### @ForcibleDefault.False
`@ForcibleDefault.Flase` returns an false instead of nil if the Decoder is unable to decode the container. 

```swift
struct Target: Decodable {
    @ForcibleDefault.False var value1: Bool
    @ForcibleDefault.True var value2: Bool
}

let json = #"{}"#.data(using: .utf8)!
let target = try! JSONDecoder().decode(Target.self, from: json)
print(target) // Target(_value1: false, _value2: true)
```

#### @ForcibleDefault.Zero
`@ForcibleDefault.Zero` returns an 0 instead of nil if the Decoder is unable to decode the container.

```swift
struct Target: Decodable {
    @ForcibleDefault.Zero var value1: Int
    @ForcibleDefault.Zero var value2: Int
}

let json = #"{ "value1": "1" }"#.data(using: .utf8)!
let target = try! JSONDecoder().decode(Target.self, from: json)
print(target) // Target(_value1: 1, _value2: 0)
```

## Examples

- [Example.playground](https://github.com/to4iki/ForcibleValue/blob/main/Example.playground/Contents.swift)

## License

ForcibleValue is released under the MIT license.
