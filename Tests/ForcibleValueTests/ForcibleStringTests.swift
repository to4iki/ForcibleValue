import Foundation
import Testing

@testable import ForcibleValue

@Suite
struct ForcibleStringTests {
  private struct Target: Decodable {
    @ForcibleString var value: String
  }

  private struct OptionTarget: Decodable {
    @ForcibleString.Option var value: String?
  }

  private struct DefaultTarget: Decodable {
    @ForcibleDefault.EmptyString var value: String
  }

  @Test(arguments: [
    TestCase(input: 1, output: "1"),
    TestCase(input: 1.1, output: "1.1"),
  ])
  func decodeSuccess(testCase: TestCase<Double, String>) throws {
    let json = """
      {
          "value": \(testCase.input)
      }
      """.data(using: .utf8)
    let target = try JSONDecoder().decode(Target.self, from: json!)
    #expect(target.value == testCase.output)
  }

  @Test(arguments: [
    TestCase(input: false, output: ()),
    TestCase(input: true, output: ()),
  ])
  func decodeError(testCase: TestCase<Bool, Void>) throws {
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
    TestCase(input: 1, output: "1"),
  ])
  func decodeOptionSuccess(testCase: TestCase<Int?, String?>) throws {
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
    TestCase(input: nil, output: ""),
    TestCase(input: 1, output: "1"),
  ])
  func decodeDefaultSuccess(testCase: TestCase<Int?, String>) throws {
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
