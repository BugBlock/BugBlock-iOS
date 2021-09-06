Pod::Spec.new do |s|
  s.name         = "BugBlock"
  s.description  = "It's a bug reporting and crash reporting framework."
  s.version      = "0.0.2"
  s.summary      = "http://bugblock.io"
  s.homepage     = "https://github.com/BugBlock/BugBlock-iOS"
  s.license      = { :type => 'Commercial', :file => 'LICENSE' }
  s.author       = { "Vadym Kozak" => "" }
  s.platform     = :ios
  s.source       = { :http => 'https://github.com/BugBlock/BugBlock-iOS/releases/download/0.1.1/BugBlock.xcframework.zip' }
  s.ios.deployment_target = '9.2'
  s.ios.vendored_frameworks = 'BugBlock.xcframework'
end
