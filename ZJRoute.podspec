#
# Be sure to run `pod lib lint ZJRoute.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZJRoute'
  s.version          = '0.1.0'
  s.summary          = 'iOS 一种跳转路由实现方式'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
iOS 一种跳转路由实现方式，可以实现Controller 之间的解耦，可以由后端接口控制前端跳转
                       DESC

  s.homepage         = 'https://github.com/MaricleZhang/ZJRoute'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MaricleZhang' => 'jian.zhang@qianli.com' }
  s.source           = { :git => 'https://github.com/MaricleZhang/ZJRoute.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZJRoute/Classes/**/*'

  s.public_header_files = 'ZJRoute/Classes/**/*.h'
  
  # s.resource_bundles = {
  #   'ZJRoute' => ['ZJRoute/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
