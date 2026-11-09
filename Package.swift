// swift-tools-version: 5.9
import PackageDescription

// Update binaryURL and binaryChecksum when cutting a new release.
// The xcframework zip is attached to the GitHub Release for each version tag.
let binaryURL =
    "https://github.com/vable-ai/vable-swift/releases/download/0.0.9/VableAI.xcframework.zip"
let binaryChecksum = "a700d35febc1e7b3b18d51fc29cbea71da1761c2aa2cf7e46f4dd4cbc2f233f4"

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
