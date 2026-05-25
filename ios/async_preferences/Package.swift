// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "async_preferences",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "async-preferences", targets: ["async_preferences"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "async_preferences",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ]
        )
    ]
)
