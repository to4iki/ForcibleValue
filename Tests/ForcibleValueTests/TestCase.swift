struct TestCase<Input: Sendable, Output: Sendable>: Sendable {
  let input: Input
  let output: Output
  let description: String

  init(input: Input, output: Output, description: String = "") {
    self.input = input
    self.output = output
    self.description = description
  }
}
