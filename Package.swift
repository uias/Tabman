// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Tabman",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Tabman",
            targets: ["Tabman"])
    ],
    dependencies: [
        .package(url: "https://github.com/uias/Pageboy", from: "4.2.0")
    ],
    targets: [
        .target(
            name: "Tabman",
            dependencies: ["Pageboy"],
            path: "Sources/Tabman",
            exclude: ["Tabman.h", "Info.plist", "PrivacyInfo.xcprivacy"],
            resources: [.process("PrivacyInfo.xcprivacy")],
            linkerSettings: [
                .linkedFramework("UIKit")
            ]
        ),
        .testTarget(
            name: "TabmanTests",
            dependencies: ["Tabman"],
            linkerSettings: [
                .linkedFramework("UIKit")
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
