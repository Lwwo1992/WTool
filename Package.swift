// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WTool",
    defaultLocalization: "zh-Hans",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "WTool",
            targets: ["WTool"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Xiaoye220/EmptyDataSet-Swift.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/SVProgressHUD/SVProgressHUD.git", .upToNextMajor(from: "2.3.0")),
        .package(url: "https://github.com/SnapKit/SnapKit.git",.upToNextMajor(from: "5.0.1")),
    ],
    targets: [
        .target(
            name: "WTool",
            dependencies:[
            "EmptyDataSet-Swift",
            "SVProgressHUD",
            "SnapKit",
            ],
            swiftSettings: [
                .define("SWIFT_PACKAGE")
            ]
        ),
        .testTarget(
            name: "WToolTests",
            dependencies: ["WTool"]),
    ]
)
