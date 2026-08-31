// swift-tools-version: 5.9

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "ScriptFlow",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "ScriptFlow",
            targets: ["AppModule"],
            bundleIdentifier: "com.studio4by5.scriptflow",
            teamIdentifier: "",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .asset("AppIcon"),
            accentColor: .presetColor(.red),
            supportedDeviceFamilies: [.phone],
            supportedInterfaceOrientations: [.portrait, .portraitUpsideDown]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            exclude: ["README.md"],
            resources: [
                .process("Assets.xcassets"),
                .copy("www")
            ]
        )
    ]
)
