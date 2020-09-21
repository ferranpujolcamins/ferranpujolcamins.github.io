// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ferranpujolcamins.github.io",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "generate",
            targets: ["bin"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ferranpujolcamins/Interplate.git", .revision("4354f59cbf0790f4c1c95d4cb68941288ee64f2f")),
        .package(name: "Path.swift", url: "https://github.com/mxcl/Path.swift.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "bin",
            dependencies: [
                .product(name: "Path", package: "Path.swift")
            ],
            path: "bin"
        ),
        .target(
            name: "lib",
            dependencies: [
                "Interplate"
            ],
            path: "lib"
        ),
    ]
)
