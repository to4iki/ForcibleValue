// swift-tools-version: 5.10

import PackageDescription

let debugSwiftSettings: [PackageDescription.SwiftSetting] = [
  .enableUpcomingFeature("ConciseMagicFile", .when(configuration: .debug)), // SE-0274
  .enableUpcomingFeature("ForwardTrailingClosures", .when(configuration: .debug)), // SE-0286
  .enableUpcomingFeature("ExistentialAny", .when(configuration: .debug)), // SE-0335
  .enableUpcomingFeature("BareSlashRegexLiterals", .when(configuration: .debug)), // SE-0354
  .enableUpcomingFeature("DeprecateApplicationMain", .when(configuration: .debug)), // SE-0383
  .enableUpcomingFeature("ImportObjcForwardDeclarations", .when(configuration: .debug)), // SE-0384
  .enableUpcomingFeature("DisableOutwardActorInference", .when(configuration: .debug)), // SE-0401
  .enableUpcomingFeature("IsolatedDefaultValues", .when(configuration: .debug)), // SE-0411
  .enableUpcomingFeature("GlobalConcurrency", .when(configuration: .debug)), // SE-0412
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
