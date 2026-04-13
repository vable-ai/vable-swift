Pod::Spec.new do |s|
  s.name             = 'VableAI'
  s.version          = '0.0.1'
  s.summary          = 'Vable AI iOS SDK - Real-time voice chat with AI'
  s.description      = <<-DESC
Vable AI iOS SDK provides real-time AI voice chat capabilities with WebRTC,
WebSocket messaging, and screen context scanning.
  DESC
  s.homepage         = 'https://vable.ai'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Vable AI' => 'support@vable.ai' }

  # Downloads the pre-built XCFramework zip directly from the GitHub Release asset.
  # CocoaPods extracts the zip and finds VableAI.xcframework inside.
  s.source           = {
    :http => "https://github.com/vable-ai/vable-swift/releases/download/#{s.version}/VableAI.xcframework.zip"
  }

  s.ios.deployment_target = '13.0'
  s.swift_versions = ['5.0']

  s.module_name  = 'VableAI'

  # Pre-built binary — no source files exposed
  s.vendored_frameworks = 'VableAI.xcframework'

  # WebRTC must still be linked by the consumer (VableAI.xcframework references it)
  s.dependency 'WebRTC-lib', '~> 125.0'

  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/WebRTC-lib/WebRTC.xcframework/ios-arm64 $(PODS_ROOT)/WebRTC-lib/WebRTC.xcframework/ios-arm64_x86_64-simulator'
  }
end
