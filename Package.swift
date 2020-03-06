// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "FerranpujolcaminsGithubIo",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(name: "FerranpujolcaminsGithubIo", targets: ["FerranpujolcaminsGithubIo"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.3.0")
    ],
    targets: [
        .target(
            name: "FerranpujolcaminsGithubIo",
            dependencies: ["Publish"]
        )
    ]
)
