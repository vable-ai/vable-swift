// swift-tools-version: 5.9
import PackageDescription

// Update binaryURL and binaryChecksum when cutting a new release.
// The xcframework zip is attached to the GitHub Release for each version tag.
let binaryURL = "https://github.com/vable-ai/vable-swift/releases/download/0.0.1/VableAI.xcframework.zip"
let binaryChecksum = "0edeb99aab49a338c195fdab25a940c6516d328f7931ab00be5488396a639bb9"

let package = Package(
    name: "VableAI",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(name: "VableAI", targets: ["VableAI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/stasel/WebRTC.git", from: "141.0.0"),
    ],
    targets: [
        .binaryTarget(
            name: "VableAIBinary",
            url: binaryURL,
            checksum: binaryChecksum
        ),
        // Thin wrapper so SPM also links WebRTC (required for symbol resolution at app link time)
        .target(
            name: "VableAI",
            dependencies: [
                "VableAIBinary",
                .product(name: "WebRTC", package: "WebRTC"),
            ],
            path: "Sources/VableAIStub"
        ),
    ]
)
