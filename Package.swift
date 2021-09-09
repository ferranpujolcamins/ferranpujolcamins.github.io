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
        .package(name: "Path.swift", url: "https://github.com/mxcl/Path.swift.git", from: "1.0.0"),
        .package(name: "Bow", url: "https://github.com/bow-swift/bow.git", .branch("master")),
        .package(name: "CSS", url: "https://github.com/ferranpujolcamins/swift-css.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "bin",
            dependencies: [
                "Site",
                .product(name: "Path", package: "Path.swift")
            ],
            path: "bin"
        ),
        .target(
            name: "Site",
            dependencies: [
                "Prelude",
                "BowUtils",
                "Lib",
            ],
            path: "Site"
        ),
        .target(
            name: "Lib",
            dependencies: [
                "HTML",
                "HTMLComponents",
                "CSS",
                "Bow",
                "Prelude"
            ],
            path: "Lib"
        ),
        .target(
            name: "HTMLComponents",
            dependencies: [
                "HTML",
                "CSS"
            ],
            path: "HTMLLib/HTMLComponents"
        ),
        .target(
            name: "HTML",
            dependencies: [
                "Bow",
            ],
            path: "HTMLLib/HTML"
        ),
        .testTarget(
            name: "HTMLTests",
            dependencies: [
                "HTML",
                "CSS"
            ],
            path: "HTMLLib/HTMLTests"
        ),
        .target(
            name: "BowUtils",
            dependencies: [
                "Bow",
                "Prelude"
            ],
            path: "BowUtils"
        ),
        .target(
            name: "Prelude",
            dependencies: [
                "Bow"
            ],
            path: "Prelude"
        ),
    ]
)
