// swift-tools-version: 5.9
import PackageDescription

// Update binaryURL and binaryChecksum when cutting a new release.
// The xcframework zip is attached to the GitHub Release for each version tag.
let binaryURL =
    "https://github.com/vable-ai/vable-swift/releases/download/0.0.6/VableAI.xcframework.zip"
let binaryChecksum = "266eb437d5c6be7509108e39196923f15bf3b3942c0eb8e2360d2529ef87f819"

let package = Package(
    name: "VableAI",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "VableAI", targets: ["VableAIWrapper"])
    ],
    dependencies: [
        .package(url: "https://github.com/stasel/WebRTC.git", from: "141.0.0")
    ],
    targets: [
        // Named like the framework in the zip, so `import VableAI` finds it
        .binaryTarget(
            name: "VableAI",
            url: binaryURL,
            checksum: binaryChecksum
        ),
        // Thin wrapper so SPM also links WebRTC (required for symbol resolution at app link time).
        // It needs its own name: called VableAI, it hid the binary's module behind an empty one.
        .target(
            name: "VableAIWrapper",
            dependencies: [
                "VableAI",
                .product(name: "WebRTC", package: "WebRTC"),
            ],
            path: "Sources/VableAIStub"
        ),
    ]
)
