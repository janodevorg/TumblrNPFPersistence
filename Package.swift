// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "TumblrNPFPersistence",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "TumblrNPFPersistence", type: .dynamic, targets: ["TumblrNPFPersistence"]),
        .library(name: "TumblrNPFPersistenceStatic", type: .static, targets: ["TumblrNPFPersistence"])
    ],
    dependencies: [
        .package(url: "git@github.com:janodevorg/CodableHelpers.git", branch: "main"),
        .package(url: "git@github.com:janodevorg/CoreDataStack.git", branch: "main"),
        .package(url: "git@github.com:janodevorg/TumblrNPF.git", branch: "main"),
        .package(url: "git@github.com:apple/swift-docc-plugin.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "TumblrNPFPersistence",
            dependencies: [
                .product(name: "CoreDataStack", package: "CoreDataStack"),
                .product(name: "CodableHelpers", package: "CodableHelpers"),
                .product(name: "TumblrNPF", package: "TumblrNPF")
            ],
            path: "sources/main",
            resources: [
                .process("resources/DataModel.xcdatamodeld")
            ]
        ),
        .testTarget(
            name: "TumblrNPFPersistenceTests",
            dependencies: ["TumblrNPFPersistence"],
            path: "sources/tests",
            resources: [
              .process("resources")
            ]
        )
    ]
)
