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

## Examples

- [Example.playground](https://github.com/to4iki/ForcibleValue/blob/main/Example.playground/Contents.swift)

## License

ForcibleValue is released under the MIT license.
