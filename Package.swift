// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "JSON",
    products: [
        .library(name: "JSON", targets: ["JSON"]),
    ],
    targets: [
        .target(name: "JSON"),
        .testTarget(name: "JSONTests"),
    ]
)
