// swift-tools-version: 6.0

import PackageDescription

let debugSwiftSettings: [PackageDescription.SwiftSetting] = [
  .enableUpcomingFeature("ExistentialAny", .when(configuration: .debug)), // SE-0335
]

let package = Package(
  name: "ForcibleValue",
  products: [
    .library(
      name: "ForcibleValue",
      targets: ["ForcibleValue"]
    )
  ],
  dependencies: [],
  targets: [
    .target(
      name: "ForcibleValue",
      dependencies: []
    ),
    .testTarget(
      name: "ForcibleValueTests",
      dependencies: ["ForcibleValue"]
    ),
  ]
)

for target in package.targets {
  target.swiftSettings = debugSwiftSettings
}
