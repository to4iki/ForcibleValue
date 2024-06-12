// swift-tools-version: 5.10

import PackageDescription

let debugSwiftSettings: [PackageDescription.SwiftSetting] = [
  .enableUpcomingFeature("ExistentialAny", .when(configuration: .debug))
]

let package = Package(
  name: "ForcibleValue",
  products: [
    .library(
      name: "ForcibleValue",
      targets: ["ForcibleValue"])
  ],
  dependencies: [],
  targets: [
    .target(
      name: "ForcibleValue",
      dependencies: []),
    .testTarget(
      name: "ForcibleValueTests",
      dependencies: ["ForcibleValue"]),
  ],
  swiftLanguageVersions: [.v5]
)

for target in package.targets {
  target.swiftSettings = debugSwiftSettings
}
