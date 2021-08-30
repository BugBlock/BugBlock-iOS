Pod::Spec.new do |s|
  s.name         = "BugBlock"
  s.version      = "0.0.1"
  s.summary      = "http://bugblock.io"
  s.homepage     = "http://bugblock.io"
  s.license      = { :type => 'Commercial', :file => 'LICENSE' }
  s.author       = { "Vadym Kozak" => "" }
  s.platform     = :ios
  s.source       = { :http => 'https://github.com/BugBlock/BugBlock-iOS/releases/download/0.0.6-alpha/BugBlock.xcframework.zip' }
  s.ios.deployment_target = '9.2'
  s.ios.vendored_frameworks = 'BugBlock.xcframework'
end
