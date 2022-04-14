import XCTest
@testable import ForcibleValue

final class ForcibleStringTests: XCTestCase {
    private struct Target: Decodable {
        @ForcibleString var value: String
    }

    private struct OptionTarget: Decodable {
        @ForcibleString.Option var value: String?
    }

    func testDecodeSuccess() throws {
        let testCases: [ParameterizedTestCase<Any, String>] = [
            .init(input: "\"string\"", output: "string"),
            .init(input: 1, output: "1"),
            .init(input: 1.1, output: "1.1")
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
            .init(input: false, output: ()),
            .init(input: true, output: ())
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

    func testOptionDecode() throws {
        let testCases: [ParameterizedTestCase<Any?, String?>] = [
            .init(input: nil, output: nil),
            .init(input: 1, output: "1")
        ]

        for testCase in testCases {
            let json: Data? = {
                if let input = testCase.input {
                    return """
                    {
                        "value": \(input)
                    }
                    """.data(using: .utf8)
                } else {
                    return "{}".data(using: .utf8)
                }
            }()

            do {
                let target = try JSONDecoder().decode(OptionTarget.self, from: json!)
                XCTAssertEqual(target.value, testCase.output)
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }
}
