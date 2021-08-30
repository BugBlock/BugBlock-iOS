Pod::Spec.new do |s|
  s.name         = "BugBlock"
  s.version      = "0.0.1"
  s.summary      = "http://bugblock.io"
  s.homepage     = "http://bugblock.io"
  s.license      = { :type => 'Commercial', :file => 'LICENSE.md' }
  s.author       = { "Vadym Kozak" => "" }
  s.platform     = :ios, '9.2'
  s.source       = { :http => 'https://github.com/BugBlock/BugBlock-iOS/releases/download/0.0.6-alpha/BugBlock.xcframework.zip' }
  s.library      = 'z'
  s.frameworks   = 'UIKit'
  s.xcconfig     =  { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/BugBlock/"' }
  s.requires_arc = true
  s.source_files = 'BugBlock.xcframework/ios-arm64_armv7/BugBlock.framework/Headers/*.{h}'
  s.vendored_frameworks = 'BugBlock.xcframework'
end
