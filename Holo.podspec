Pod::Spec.new do |s|
  s.name             = 'Holo'
  s.version          = '0.1.1'
  s.summary          = 'A short description of Holo.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/noppefoxwolf/Holo'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'noppefoxwolf' => 'noppelabs@gmail.com' }
  s.source           = { :git => 'https://github.com/noppefoxwolf/Holo.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/noppefoxwolf'
  s.ios.deployment_target = '10.0'
  s.source_files = 'Holo/Classes/**/*'
  s.swift_version = '5.0'
end
