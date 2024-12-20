// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TP_Packages",
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            from: "1.0.0"
        ),
        .package(path: "../MyUtils"),
        .package(path: "../PileInt")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "TP_Packages",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "MyUtils",
                "PileInt"
            ]
        )
    ]
)