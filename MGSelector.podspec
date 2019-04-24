#
# Be sure to run `pod lib lint MGSelector.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MGSelector'
  s.version          = '0.2'
  s.summary          = 'A customized table selector for iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
MGSelector is a customized table selector for iOS.
                       DESC

  s.homepage         = 'https://github.com/lm2343635/MGSelector'
  s.screenshots     = 'https://github.com/lm2343635/MGSelector/raw/master/screenshoot/light.png', 'https://github.com/lm2343635/MGSelector/raw/master/screenshoot/dark.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lm2343635' => 'lm2343635@126.com' }
  s.source           = { :git => 'https://github.com/lm2343635/MGSelector.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.fczm.pw'

  s.ios.deployment_target = '10.0'

  s.source_files = 'MGSelector/Classes/**/*'
  s.dependency 'SnapKit', '~> 5'
end
