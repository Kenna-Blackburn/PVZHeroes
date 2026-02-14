//
//  Package.swift
//  PVZHeroes
//
//  Created by Kenna Blackburn on 2/13/26.
//

// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "PVZHeroes",
    platforms: [.macOS(.v26)],
    products: [
        .library(
            name: "PVZHeroes",
            targets: ["PVZHeroes"],
        ),
    ],
    targets: [
        .target(
            name: "Helpers",
        ),
        .target(
            name: "PVZHeroes",
            dependencies: ["Helpers"],
        ),
        .testTarget(
            name: "PVZHeroesTests",
            dependencies: ["PVZHeroes"],
        ),
    ],
)
