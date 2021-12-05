import XCTest
@testable import ForcibleValue

final class ForcibleBoolTests: XCTestCase {
    private struct Target: Decodable {
        @ForcibleBool var value: Bool
    }

    func testDecodeSuccess() throws {
        let testCases: [ParameterizedTestCase<Any, Bool>] = [
            .init(input: false, output: false),
            .init(input: true, output: true),
            .init(input: 0, output: false),
            .init(input: 1, output: true),
            .init(input: "\"false\"", output: false),
            .init(input: "\"true\"", output: true),
        ]

        for testCase in testCases {
            let json = """
            {
                "value": \(testCase.input)
            }
            """.data(using: .utf8)

            do {
                let target = try JSONDecoder().decode(Target.self, from: json!)
                XCTAssertEqual(target.value, testCase.output)
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }

    func testDecodeError() throws {
        let testCases: [ParameterizedTestCase<Any, Void>] = [
            .init(input: -1, output: ()),
            .init(input: 2, output: ()),
            .init(input: "\"f\"", output: ()),
            .init(input: "\"t\"", output: ()),
            .init(input: 1.1, output: ())
        ]

        for testCase in testCases {
            let json = """
            {
                "value": \(testCase.input)
            }
            """.data(using: .utf8)

            XCTAssertThrowsError(
                try JSONDecoder().decode(Target.self, from: json!)
            )
        }
    }
}
