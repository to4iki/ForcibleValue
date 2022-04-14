import Foundation
import ForcibleValue

struct User: Decodable {
    @ForcibleString var fullName: String
    @ForcibleString.Option var nickName: String?
    @ForcibleInt var age: Int
    @ForcibleDouble var height: Double
    @ForcibleFloat var weight: Float
    @ForcibleBool var isAdmin: Bool
}

let json = """
{
    "fullName": 123,
    "age": "30",
    "height": "172.3",
    "weight": "60.0",
    "isAdmin": 1
}
""".data(using: .utf8)

do {
    let user = try JSONDecoder().decode(User.self, from: json!)
    print(user) // User(_fullName: 123, _nickName: nil, _age: 30, _height: 172.3, _weight: 60.0, _isAdmin: true)
} catch {
    print(error)
}
