// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ferranpujolcamins.github.io",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(
            name: "generate",
            targets: ["bin"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ferranpujolcamins/Interplate.git", .revision("4354f59cbf0790f4c1c95d4cb68941288ee64f2f")),
        .package(name: "Path.swift", url: "https://github.com/mxcl/Path.swift.git", from: "1.0.0"),
        .package(url: "https://github.com/vapor-community/HTMLKit.git", from: "2.0.0"),
        .package(name: "Bow", url: "https://github.com/bow-swift/bow.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "bin",
            dependencies: [
                "site",
                .product(name: "Path", package: "Path.swift")
            ],
            path: "bin"
        ),
        .target(
            name: "site",
            dependencies: [
                "Lib",
            ],
            path: "site"
        ),
        .target(
            name: "Lib",
            dependencies: [
                "Interplate",
                "HTMLKit",
                "Bow"
            ],
            path: "Lib"
        ),
    ]
)
