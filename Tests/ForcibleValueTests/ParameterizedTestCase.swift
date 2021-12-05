public struct ParameterizedTestCase<Input, Output> {
    public let input: Input
    public let output: Output
    public let description: String
    public let file: StaticString
    public let line: UInt

    public init(
        input: Input,
        output: Output,
        description: String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) {
        self.input = input
        self.output = output
        self.description = description
        self.file = file
        self.line = line
    }
}
