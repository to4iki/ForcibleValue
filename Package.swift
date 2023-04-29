// swift-tools-version:5.0

import PackageDescription

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
