// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "Tabman",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Tabman",
            targets: ["Tabman"])
    ],
    dependencies: [
        .package(url: "https://github.com/uias/Pageboy", from: "5.0.1")
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
    swiftLanguageModes: [.v5, .v6]
)
