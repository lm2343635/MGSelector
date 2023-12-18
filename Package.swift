// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "MGSelector",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "MGSelector", targets: ["MGSelector"])
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
        .target(name: "MGSelector", dependencies: ["SnapKit"], path: "MGSelector")
    ],
    swiftLanguageVersions: [.v5]
)
