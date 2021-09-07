Pod::Spec.new do |s|
  s.name         = 'BugBlock'
  s.version      = '0.1.2'
  s.summary      = 'summary'
  s.description  = <<-DESC
    Bugreporting and crash reporting tool.
    DESC
  s.homepage     = 'https://dashboard.bugblock.io'
  s.license      = { :type => 'Commercial', :file => 'LICENSE.md' }
  s.author       = { 'BugBlock Team' => 'support.io' }
  s.platform     = :ios, '11.0'
  s.source       = { :git => 'https://github.com/BugBlock/BugBlock-iOS.git', :tag => '0.1.2' }
  s.library      = 'z'
  s.requires_arc = true
  s.xcconfig     =  { 'FRAMEWORK_SEARCH_PATHS' => '$(PODS_ROOT)/BugBlock/' }
  s.vendored_frameworks = 'build/BugBlock.xcframework'
  
end
