// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "TumblrNPFPersistence",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "TumblrNPFPersistence", type: .static, targets: ["TumblrNPFPersistence"]),
        .library(name: "TumblrNPFPersistenceDynamic", type: .dynamic, targets: ["TumblrNPFPersistence"])
    ],
    dependencies: [
        .package(url: "git@github.com:janodevorg/CodableHelpers.git", from: "1.0.0"),
        .package(url: "git@github.com:janodevorg/CoreDataStack.git", from: "1.0.4"),
        .package(url: "git@github.com:janodevorg/TumblrNPF.git", from: "1.0.1"),
        .package(url: "git@github.com:apple/swift-docc-plugin.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "TumblrNPFPersistence",
            dependencies: [
                .product(name: "CoreDataStackDynamic", package: "CoreDataStack"),
                .product(name: "CodableHelpersDynamic", package: "CodableHelpers"),
                .product(name: "TumblrNPFDynamic", package: "TumblrNPF")
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
