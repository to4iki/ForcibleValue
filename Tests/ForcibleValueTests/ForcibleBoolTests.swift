import Foundation
import Testing

@testable import ForcibleValue

@Suite
struct ForcibleBoolTests {
  private struct Target: Decodable {
    @ForcibleBool var value: Bool
  }

  private struct OptionTarget: Decodable {
    @ForcibleBool.Option var value: Bool?
  }

  private struct DefaultTarget: Decodable {
    @ForcibleDefault.False var value: Bool
  }

  @Test(arguments: [
    TestCase(input: false, output: false),
    TestCase(input: true, output: true),
    TestCase(input: 0, output: false),
    TestCase(input: 1, output: true),
    TestCase(input: "\"false\"", output: false),
    TestCase(input: "\"true\"", output: true),
  ])
  func decodeSuccess(testCase: TestCase<Any, Bool>) throws {
    let json = """
      {
          "value": \(testCase.input)
      }
      """.data(using: .utf8)
    let target = try JSONDecoder().decode(Target.self, from: json!)
    #expect(target.value == testCase.output)
  }

  @Test(arguments: [
    TestCase(input: -1, output: ()),
    TestCase(input: 2, output: ()),
    TestCase(input: "\"f\"", output: ()),
    TestCase(input: "\"t\"", output: ()),
    TestCase(input: 1.1, output: ()),
  ])
  func decodeError(testCase: TestCase<Any, Void>) throws {
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
    TestCase(input: 0, output: false),
  ])
  func decodeOptionSuccess(testCase: TestCase<Any?, Bool?>) throws {
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
    TestCase(input: nil, output: false),
    TestCase(input: 1, output: true),
  ])
  func decodeDefaultSuccess(testCase: TestCase<Any?, Bool>) throws {
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
