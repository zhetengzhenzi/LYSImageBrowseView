
Pod::Spec.new do |s|
  s.name             = "LYSImageBrowseView"
  s.version          = "0.0.1"
  s.summary          = "Realize image zooming browsing"
  s.homepage         = "https://github.com/zhetengzhenzi/LYSImageBrowseView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "liuyushuang@duia.com" => "liuyushuang@duia.com" }
  s.source           = { :git => "https://github.com/zhetengzhenzi/LYSImageBrowseView.git", :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  s.source_files = 'LYSImageBrowseView/Classes/**/*'
  s.resource_bundles = {
    'LYSImageBrowseView' => ['LYSImageBrowseView/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
