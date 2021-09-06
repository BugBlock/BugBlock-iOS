// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BugBlock",
    platforms: [.iOS(SupportedPlatform.IOSVersion.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "BugBlock",
            targets: ["BugBlock"]),
    ],
    targets: [
            .binaryTarget(name: "BugBlock",
                          url: "https://github.com/BugBlock/BugBlock-iOS/releases/download/0.1.0/BugBlock.xcframework.zip")
    ]
)
