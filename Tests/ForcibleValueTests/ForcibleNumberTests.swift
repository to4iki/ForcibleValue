import XCTest

@testable import ForcibleValue

final class ForcibleNumberTests: XCTestCase {
  private struct Target: Decodable {
    @ForcibleNumber var value: Int
  }

  private struct OptionTarget: Decodable {
    @ForcibleNumber.Option var value: Int?
  }

  private struct DefaultTarget: Decodable {
    @ForcibleDefault.Zero var value: Int
  }

  func testDecodeSuccess() throws {
    let testCases: [ParameterizedTestCase<Any, Int>] = [
      .init(input: 1, output: 1),
      .init(input: "\"1\"", output: 1),
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
      .init(input: "\"abc\"", output: ())
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
    let testCases: [ParameterizedTestCase<Any?, Int?>] = [
      .init(input: nil, output: nil),
      .init(input: "\"1\"", output: 1),
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

  func testDefaultValueDecode() throws {
    let testCases: [ParameterizedTestCase<Any?, Int>] = [
      .init(input: nil, output: 0),
      .init(input: "\"1\"", output: 1),
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
        let target = try JSONDecoder().decode(DefaultTarget.self, from: json!)
        XCTAssertEqual(target.value, testCase.output)
      } catch {
        XCTFail(error.localizedDescription)
      }
    }
  }
}
