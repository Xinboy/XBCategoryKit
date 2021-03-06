#
# Be sure to run `pod lib lint FunctionModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XBCategoryKit'
  s.version          = '0.4.0'
  s.summary          = '分类组件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
							TODO: 分类组件，主要集合各种分类
                       DESC

  s.homepage         = 'https://github.com/Xinboy/XBCategoryKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '洪新博' => 'xinbo.hong@hotmail.com' }
  s.source           = { :git => 'git@github.com:Xinboy/XBCategoryKit.git', :tag => s.version.to_s }


  s.platform    = :ios, "8.0"
  s.ios.deployment_target = '8.0'

  s.source_files = 'XBCategoryKit/Classes/**/*.{h,m}'
  
  # s.resource_bundles = {
  #   'FunctionModule' => ['XBCategoryKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  s.dependency 'Masonry'
end
