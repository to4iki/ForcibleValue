import Foundation
import ForcibleValue

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
