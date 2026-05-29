// swift-tools-version: 6.0
import PackageDescription

let reproSwiftSettings: [SwiftSetting] = [
  .unsafeFlags([
    "-strict-concurrency=complete",
    "-enable-experimental-feature", "SendableCompletionHandlers",
    "-warnings-as-errors",
  ]),
]

let package = Package(
  name: "SwiftAttrPayloadCollisionRepro",
  products: [
    .library(name: "SendableFirstWitness", targets: ["SendableFirstWitness"]),
    .library(name: "UIActorFirstWitness", targets: ["UIActorFirstWitness"]),
  ],
  targets: [
    .target(name: "SendableFirstAPI", publicHeadersPath: "include"),
    .target(name: "UIActorFirstAPI", publicHeadersPath: "include"),
    .target(
      name: "SendableFirstWitness",
      dependencies: ["SendableFirstAPI"],
      swiftSettings: reproSwiftSettings),
    .target(
      name: "UIActorFirstWitness",
      dependencies: ["UIActorFirstAPI"],
      swiftSettings: reproSwiftSettings),
  ],
  swiftLanguageModes: [.v6]
)
