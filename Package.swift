// swift-tools-version: 5.9
import PackageDescription

// Update binaryURL and binaryChecksum when cutting a new release.
// The xcframework zip is attached to the GitHub Release for each version tag.
let binaryURL =
    "https://github.com/vable-ai/vable-swift/releases/download/0.0.12/VableAI.xcframework.zip"
let binaryChecksum = "648f37e67d9c3b1ddcdd5848a950d5fc66b4169b102b48fd6d7aca6a6010f9e0"

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
