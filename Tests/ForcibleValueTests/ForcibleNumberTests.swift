import Foundation
import Testing

@testable import ForcibleValue

@Suite
struct ForcibleNumberTests {
  private struct Target: Decodable {
    @ForcibleNumber var value: Int
  }

  private struct OptionTarget: Decodable {
    @ForcibleNumber.Option var value: Int?
  }

  private struct DefaultTarget: Decodable {
    @ForcibleDefault.Zero var value: Int
  }

  @Test(arguments: [
    TestCase(input: "\"1\"", output: 1)
  ])
  func decodeSuccess(testCase: TestCase<String, Int>) throws {
    let json = """
      {
          "value": \(testCase.input)
      }
      """.data(using: .utf8)
    let target = try JSONDecoder().decode(Target.self, from: json!)
    #expect(target.value == testCase.output)
  }

  @Test(arguments: [
    TestCase(input: "\"abc\"", output: ())
  ])
  func decodeError(testCase: TestCase<String, Void>) throws {
    let json = """
      {
          "value": \(testCase.input)
      }
      """.data(using: .utf8)
    #expect(throws: (any Error).self) {
      try JSONDecoder().decode(Target.self, from: json!)
    }
  }

  @Test(arguments: [
    TestCase(input: nil, output: nil),
    TestCase(input: "\"1\"", output: 1),
  ])
  func decodeOptionSuccess(testCase: TestCase<String?, Int?>) throws {
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
    let target = try JSONDecoder().decode(OptionTarget.self, from: json!)
    #expect(target.value == testCase.output)
  }

  @Test(arguments: [
    TestCase(input: nil, output: 0),
    TestCase(input: "\"1\"", output: 1),
  ])
  func decodeDefaultSuccess(testCase: TestCase<String?, Int>) throws {
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
    let target = try JSONDecoder().decode(DefaultTarget.self, from: json!)
    #expect(target.value == testCase.output)
  }
}
