Pod::Spec.new do |s|
  s.name         = 'BugBlock'
  s.version      = '0.1.5'
  s.summary      = 'summary'
  s.description  = <<-DESC
    Bugreporting and crash reporting tool.
    DESC
  s.homepage     = 'https://dashboard.bugblock.io'
  s.license      = { :type => 'Commercial', :file => 'LICENCE' }
  s.author       = { 'BugBlock Team' => 'support.io' }
  s.platform     = :ios, '11.0'
  s.source       = { :git => 'https://github.com/BugBlock/BugBlock-iOS.git', :tag => '0.1.5' }
  
  s.source_files = 'build/BugBlock.xcframework/**/*.{h,m,swift}'
  s.vendored_frameworks = 'build/BugBlock.xcframework'
  s.preserve_paths =  'build/BugBlock.xcframework/*'
  
end
