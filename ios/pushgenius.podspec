Pod::Spec.new do |s|
  s.name             = "pushgenius"
  s.version          = "0.1.0"
  s.summary          = "PushGenius Flutter plugin"
  s.homepage         = "https://pushgeni.us"
  s.license          = { :type => "MIT", :file => "../LICENSE" }
  s.authors          = "PushGenius"
  s.source           = { :path => "." }
  s.source_files     = "pushgenius/Sources/pushgenius/**/*.swift"
  s.dependency "Flutter"
  s.platform         = :ios, "15.0"
  s.swift_version    = "5.9"
  s.frameworks       = "UserNotifications"
  s.resource_bundles = { "pushgenius_privacy" => ["pushgenius/Sources/pushgenius/Core/PrivacyInfo.xcprivacy"] }
  s.pod_target_xcconfig = { "DEFINES_MODULE" => "YES" }
end
