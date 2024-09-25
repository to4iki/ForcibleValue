struct TestCase<Input, Output> {
  let input: Input
  let output: Output
  let description: String

  init(input: Input, output: Output, description: String = "") {
    self.input = input
    self.output = output
    self.description = description
  }
}
